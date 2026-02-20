package com.bank.BankingSystem1.model;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

//package com.bank.BankingSystem.model;

//import javax.persistence.DiscriminatorValue;
//import javax.persistence.Entity;

/**
 * JPA entity for Savings accounts.
 * Discriminator value "SAVINGS" maps to the account_type column.
 */
@Entity
@DiscriminatorValue("SAVINGS")
public class SavingsAccount extends BankAccount {

    private static final double INTEREST_RATE   = 4.00;
    private static final double MINIMUM_BALANCE = 500.00;

    public SavingsAccount(String accountNumber, String holderName,
                          String email, String phone, double initialBalance) {
        super(accountNumber, holderName, email, phone, initialBalance);
    }

    public SavingsAccount() {}

    @Override public double getInterestRate()    { return INTEREST_RATE; }
    @Override public double getMinimumBalance()  { return MINIMUM_BALANCE; }
    @Override public String getAccountTypeName() { return "SAVINGS"; }
}
