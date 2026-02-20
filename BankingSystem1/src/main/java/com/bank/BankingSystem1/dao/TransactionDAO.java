package com.bank.BankingSystem1.dao;

//package com.bank.BankingSystem.dao;
//
//import com.bank.BankingSystem.model.Transaction;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.bank.BankingSystem1.model.Transaction;

import java.util.List;

/**
 * JPA-based Data Access Object for Transaction entities.
 *
 * Key improvements over original JDBC DAO:
 *  - No manual ResultSet → object mapping
 *  - JPQL pagination via setMaxResults
 *  - @ManyToOne relationship means Hibernate loads account lazily (no extra JOIN)
 */
public class TransactionDAO {

    private final EntityManager em;

    public TransactionDAO(EntityManager em) {
        this.em = em;
    }

    // ── CREATE ──────────────────────────────────────────────────────────────

    public Transaction save(Transaction txn) {
        em.persist(txn);
        return txn;
    }

    // ── READ ────────────────────────────────────────────────────────────────

    public List<Transaction> getTransactionHistory(int accountId) {
        TypedQuery<Transaction> query = em.createQuery(
            "SELECT t FROM Transaction t WHERE t.account.accountId = :id " +
            "ORDER BY t.transactionDate DESC",
            Transaction.class);
        query.setParameter("id", accountId);
        return query.getResultList();
    }

    public List<Transaction> getRecentTransactions(int accountId, int limit) {
        TypedQuery<Transaction> query = em.createQuery(
            "SELECT t FROM Transaction t WHERE t.account.accountId = :id " +
            "ORDER BY t.transactionDate DESC",
            Transaction.class);
        query.setParameter("id", accountId);
        query.setMaxResults(limit);   // JPQL pagination — replaces SQL LIMIT ?
        return query.getResultList();
    }
}