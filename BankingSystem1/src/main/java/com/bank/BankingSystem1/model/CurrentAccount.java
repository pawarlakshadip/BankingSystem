package com.bank.BankingSystem1.model;

//package com.bank.BankingSystem.model;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

/**
 * JPA entity for Current accounts.
 */
@Entity
@DiscriminatorValue("CURRENT")
public class CurrentAccount extends BankAccount {

    private static final double INTEREST_RATE   = 0.00;
    private static final double MINIMUM_BALANCE = 1000.00;

    public CurrentAccount(String accountNumber, String holderName,
                          String email, String phone, double initialBalance) {
        super(accountNumber, holderName, email, phone, initialBalance);
    }

    public CurrentAccount() {}

    @Override public double getInterestRate()    { return INTEREST_RATE; }
    @Override public double getMinimumBalance()  { return MINIMUM_BALANCE; }
    @Override public String getAccountTypeName() { return "CURRENT"; }
}