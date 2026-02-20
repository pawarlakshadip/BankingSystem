package com.bank.BankingSystem1.service;

//package com.bank.BankingSystem.service;
//
//import com.bank.BankingSystem.dao.AccountDAO;
//import com.bank.BankingSystem.dao.TransactionDAO;
//import com.bank.BankingSystem.model.*;
//import com.bank.BankingSystem.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

import com.bank.BankingSystem1.dao.AccountDAO;
import com.bank.BankingSystem1.dao.TransactionDAO;
import com.bank.BankingSystem1.model.BankAccount;
import com.bank.BankingSystem1.model.Transaction;
import com.bank.BankingSystem1.util.JPAUtil;

import java.util.List;

/**
 * Service layer that wraps all banking operations in JPA transactions.
 *
 * Improvements over the original JDBC-based service:
 *  - EntityTransaction replaces manual conn.setAutoCommit(false) / commit / rollback
 *  - EntityManager is created and closed per operation (thread-safe; no shared singleton)
 *  - HikariCP connection pool means each em.getTransaction() reuses a pooled connection
 *  - No JDBC Connection objects passed between methods
 */
public class BankingService {

    // ── Account Management ──────────────────────────────────────────────────

    public BankAccount createAccount(BankAccount account) {
        validateInitialBalance(account);
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountDAO dao = new AccountDAO(em);
            dao.save(account);
            tx.commit();
            return account;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public BankAccount getAccount(String accountNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            AccountDAO dao = new AccountDAO(em);
            BankAccount account = dao.findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + accountNumber));
            if (!account.isActive())
                throw new IllegalStateException("Account is deactivated: " + accountNumber);
            return account;
        } finally {
            em.close();
        }
    }

    public List<BankAccount> getAllAccounts() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return new AccountDAO(em).findAll();
        } finally {
            em.close();
        }
    }

    public boolean updateAccount(BankAccount account) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            new AccountDAO(em).update(account);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public boolean closeAccount(String accountNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountDAO  accountDAO  = new AccountDAO(em);
            TransactionDAO txnDAO   = new TransactionDAO(em);

            BankAccount account = accountDAO.findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + accountNumber));
            if (!account.isActive()) throw new IllegalStateException("Account is already closed.");

            double remaining = account.getBalance();
            if (remaining > 0) {
                account.setBalance(0.0);
                accountDAO.update(account);

                txnDAO.save(new Transaction(
                    account, Transaction.Type.WITHDRAWAL, remaining, 0.0,
                    "Account closure - full balance refunded: ₹" + remaining));
            }

            accountDAO.deactivate(account.getAccountId());
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // ── Transactions ────────────────────────────────────────────────────────

    public double deposit(String accountNumber, double amount) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountDAO     accDAO = new AccountDAO(em);
            TransactionDAO txnDAO = new TransactionDAO(em);

            BankAccount account = accDAO.findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + accountNumber));
            validateActiveAccount(account, accountNumber);

            account.deposit(amount);          // domain-level validation
            accDAO.update(account);

            txnDAO.save(new Transaction(
                account, Transaction.Type.DEPOSIT, amount, account.getBalance(), "Cash deposit"));

            tx.commit();
            return account.getBalance();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public double withdraw(String accountNumber, double amount) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountDAO     accDAO = new AccountDAO(em);
            TransactionDAO txnDAO = new TransactionDAO(em);

            BankAccount account = accDAO.findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + accountNumber));
            validateActiveAccount(account, accountNumber);

            account.withdraw(amount);         // polymorphic — FixedDeposit throws here
            accDAO.update(account);

            txnDAO.save(new Transaction(
                account, Transaction.Type.WITHDRAWAL, amount, account.getBalance(), "Cash withdrawal"));

            tx.commit();
            return account.getBalance();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void transfer(String fromNumber, String toNumber, double amount) {
        if (fromNumber.equals(toNumber))
            throw new IllegalArgumentException("Cannot transfer to the same account.");

        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            AccountDAO     accDAO = new AccountDAO(em);
            TransactionDAO txnDAO = new TransactionDAO(em);

            BankAccount from = accDAO.findByAccountNumber(fromNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + fromNumber));
            BankAccount to   = accDAO.findByAccountNumber(toNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found: " + toNumber));

            validateActiveAccount(from, fromNumber);
            validateActiveAccount(to,   toNumber);

            from.withdraw(amount);
            to.deposit(amount);

            accDAO.update(from);
            accDAO.update(to);

            txnDAO.save(new Transaction(from, Transaction.Type.TRANSFER_OUT,
                amount, from.getBalance(), "Transfer to " + toNumber));
            txnDAO.save(new Transaction(to,   Transaction.Type.TRANSFER_IN,
                amount, to.getBalance(),   "Transfer from " + fromNumber));

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // ── History ─────────────────────────────────────────────────────────────

    public List<Transaction> getTransactionHistory(String accountNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            BankAccount account = new AccountDAO(em).findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found."));
            return new TransactionDAO(em).getTransactionHistory(account.getAccountId());
        } finally {
            em.close();
        }
    }

    public List<Transaction> getMiniStatement(String accountNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            BankAccount account = new AccountDAO(em).findByAccountNumber(accountNumber)
                .orElseThrow(() -> new IllegalArgumentException("Account not found."));
            return new TransactionDAO(em).getRecentTransactions(account.getAccountId(), 5);
        } finally {
            em.close();
        }
    }

    // ── Helpers ──────────────────────────────────────────────────────────────

    private void validateActiveAccount(BankAccount account, String accountNumber) {
        if (account == null)     throw new IllegalArgumentException("Account not found: " + accountNumber);
        if (!account.isActive()) throw new IllegalStateException("Account is deactivated: " + accountNumber);
    }

    private void validateInitialBalance(BankAccount account) {
        if (account.getBalance() < account.getMinimumBalance()) {
            throw new IllegalArgumentException(String.format(
                "Initial balance %.2f is below the minimum required balance of %.2f for %s accounts.",
                account.getBalance(), account.getMinimumBalance(), account.getAccountTypeName()));
        }
    }

    public String generateAccountNumber() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            long count = new AccountDAO(em).countAll();
            return "ACC" + (1000 + count + 1);
        } finally {
            em.close();
        }
    }
}
