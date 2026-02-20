package com.bank.BankingSystem1.model;

//package com.bank.BankingSystem.model;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * JPA entity representing a single bank transaction record.
 *
 * @ManyToOne relationship to BankAccount enables Hibernate to load
 * transaction history via JPQL without manual ResultSet mapping.
 */
@Entity
@Table(name = "transactions", indexes = {
    @Index(name = "idx_txn_account", columnList = "account_id"),
    @Index(name = "idx_txn_date",    columnList = "transaction_date")
})
public class Transaction {

    public enum Type { DEPOSIT, WITHDRAWAL, TRANSFER_IN, TRANSFER_OUT }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "transaction_id")
    private int transactionId;

    // Many transactions belong to one account
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "account_id", nullable = false)
    private BankAccount account;

    @Enumerated(EnumType.STRING)
    @Column(name = "transaction_type", nullable = false, length = 20)
    private Type transactionType;

    @Column(name = "amount", nullable = false)
    private double amount;

    @Column(name = "balance_after", nullable = false)
    private double balanceAfter;

    @Column(name = "description", length = 255)
    private String description;

    @Column(name = "transaction_date", nullable = false, updatable = false)
    private LocalDateTime transactionDate;

    @PrePersist
    public void prePersist() {
        if (this.transactionDate == null) {
            this.transactionDate = LocalDateTime.now();
        }
    }

    // ── Constructors ────────────────────────────────────────────────────────

    public Transaction() {}

    public Transaction(BankAccount account, Type transactionType,
                       double amount, double balanceAfter, String description) {
        this.account         = account;
        this.transactionType = transactionType;
        this.amount          = amount;
        this.balanceAfter    = balanceAfter;
        this.description     = description;
    }

    // ── Getters & Setters ───────────────────────────────────────────────────

    public int           getTransactionId()                        { return transactionId; }
    public void          setTransactionId(int id)                  { this.transactionId = id; }

    public BankAccount   getAccount()                              { return account; }
    public void          setAccount(BankAccount account)           { this.account = account; }

    public Type          getTransactionType()                      { return transactionType; }
    public void          setTransactionType(Type type)             { this.transactionType = type; }

    public double        getAmount()                               { return amount; }
    public void          setAmount(double amount)                  { this.amount = amount; }

    public double        getBalanceAfter()                         { return balanceAfter; }
    public void          setBalanceAfter(double balanceAfter)      { this.balanceAfter = balanceAfter; }

    public String        getDescription()                          { return description; }
    public void          setDescription(String description)        { this.description = description; }

    public LocalDateTime getTransactionDate()                      { return transactionDate; }
    public void          setTransactionDate(LocalDateTime date)    { this.transactionDate = date; }

    @Override
    public String toString() {
        return String.format("[%s] %-15s | Amount: %8.2f | Balance After: %10.2f | %s",
            transactionDate, transactionType, amount, balanceAfter,
            description != null ? description : "");
    }
}