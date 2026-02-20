package com.bank.BankingSystem1.model;

//package com.bank.BankingSystem.model;

import javax.persistence.*;

/**
 * Abstract JPA entity representing a generic bank account.
 *
 * Uses SINGLE_TABLE inheritance strategy for performance:
 *   - Only ONE table (accounts) needed for all subtypes
 *   - No JOINs required when loading accounts → faster queries
 *
 * Replaces the plain POJO + manual ResultSet mapping from the original project.
 */
@Entity
@Table(name = "accounts")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "account_type", discriminatorType = DiscriminatorType.STRING)
public abstract class BankAccount {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "account_id")
    protected int accountId;

    @Column(name = "account_number", unique = true, nullable = false, length = 20)
    protected String accountNumber;

    @Column(name = "holder_name", nullable = false, length = 100)
    protected String holderName;

    @Column(name = "email", length = 100)
    protected String email;

    @Column(name = "phone", length = 20)
    protected String phone;

    @Column(name = "balance", nullable = false)
    protected double balance;

    @Column(name = "is_active", nullable = false)
    protected boolean isActive = true;

    // ── Constructors ────────────────────────────────────────────────────────

    public BankAccount(String accountNumber, String holderName,
                       String email, String phone, double initialBalance) {
        this.accountNumber = accountNumber;
        this.holderName    = holderName;
        this.email         = email;
        this.phone         = phone;
        this.balance       = initialBalance;
        this.isActive      = true;
    }

    protected BankAccount() {}

    // ── Abstract methods – each subtype implements its own rules ────────────

    public abstract double getInterestRate();
    public abstract double getMinimumBalance();
    public abstract String getAccountTypeName();

    // ── Business logic ──────────────────────────────────────────────────────

    public void deposit(double amount) {
        if (amount <= 0) throw new IllegalArgumentException("Deposit amount must be positive.");
        this.balance += amount;
    }

    public void withdraw(double amount) {
        if (amount <= 0) throw new IllegalArgumentException("Withdrawal amount must be positive.");
        if ((this.balance - amount) < getMinimumBalance()) {
            throw new IllegalStateException(
                String.format("Insufficient funds. Minimum balance of %.2f must be maintained.",
                              getMinimumBalance()));
        }
        this.balance -= amount;
    }

    // ── Getters & Setters ───────────────────────────────────────────────────

    public int    getAccountId()                    { return accountId; }
    public void   setAccountId(int id)              { this.accountId = id; }

    public String getAccountNumber()                { return accountNumber; }
    public void   setAccountNumber(String num)      { this.accountNumber = num; }

    public String getHolderName()                   { return holderName; }
    public void   setHolderName(String name)        { this.holderName = name; }

    public String getEmail()                        { return email; }
    public void   setEmail(String email)            { this.email = email; }

    public String getPhone()                        { return phone; }
    public void   setPhone(String phone)            { this.phone = phone; }

    public double getBalance()                      { return balance; }
    public void   setBalance(double balance)        { this.balance = balance; }

    public boolean isActive()                       { return isActive; }
    public void    setActive(boolean active)        { this.isActive = active; }

    @Override
    public String toString() {
        return String.format("Account[%s | %s | %s | Balance: %.2f | Active: %s]",
            accountNumber, getAccountTypeName(), holderName, balance, isActive);
    }
}
