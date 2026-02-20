package com.bank.BankingSystem1.dao;
//
//package com.bank.BankingSystem.dao;
//
//import com.bank.BankingSystem.model.BankAccount;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.bank.BankingSystem1.model.BankAccount;

import java.util.List;
import java.util.Optional;

/**
 * JPA-based Data Access Object for BankAccount entities.
 *
 * Key improvements over the original JDBC DAO:
 *  - No raw SQL / ResultSet mapping required — Hibernate handles it
 *  - JPQL queries are type-safe and database-agnostic
 *  - The EntityManager is injected per-request, making this thread-safe
 */
public class AccountDAO {

    private final EntityManager em;

    public AccountDAO(EntityManager em) {
        this.em = em;
    }

    // ── CREATE ──────────────────────────────────────────────────────────────

    public BankAccount save(BankAccount account) {
        em.persist(account);
        return account;
    }

    // ── READ ────────────────────────────────────────────────────────────────

    public Optional<BankAccount> findByAccountNumber(String accountNumber) {
        TypedQuery<BankAccount> query = em.createQuery(
            "SELECT a FROM BankAccount a WHERE a.accountNumber = :num",
            BankAccount.class);
        query.setParameter("num", accountNumber);
        return query.getResultStream().findFirst();
    }

    public Optional<BankAccount> findById(int accountId) {
        return Optional.ofNullable(em.find(BankAccount.class, accountId));
    }

    public List<BankAccount> findAll() {
        return em.createQuery(
            "SELECT a FROM BankAccount a ORDER BY a.accountId",
            BankAccount.class).getResultList();
    }

    public List<BankAccount> findAllActive() {
        return em.createQuery(
            "SELECT a FROM BankAccount a WHERE a.isActive = true ORDER BY a.accountId",
            BankAccount.class).getResultList();
    }

    // ── UPDATE ──────────────────────────────────────────────────────────────

    /**
     * Merges the detached entity state back into the persistence context.
     * Hibernate automatically issues an UPDATE on flush/commit.
     */
    public BankAccount update(BankAccount account) {
        return em.merge(account);
    }

    // ── SOFT DELETE ─────────────────────────────────────────────────────────

    public void deactivate(int accountId) {
        BankAccount account = em.find(BankAccount.class, accountId);
        if (account != null) {
            account.setActive(false);
            em.merge(account);
        }
    }

    // ── HELPERS ─────────────────────────────────────────────────────────────

    public long countAll() {
        return em.createQuery("SELECT COUNT(a) FROM BankAccount a", Long.class)
                 .getSingleResult();
    }
}
