package com.bank.BankingSystem1.model;

//package com.bank.BankingSystem.model;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

/**
 * JPA entity for Fixed Deposit accounts.
 * Withdrawals are not permitted.
 */
@Entity
@DiscriminatorValue("FIXED_DEPOSIT")
public class FixedDepositAccount extends BankAccount {

    private static final double INTEREST_RATE   = 7.50;
    private static final double MINIMUM_BALANCE = 5000.00;

    public FixedDepositAccount(String accountNumber, String holderName,
                               String email, String phone, double initialBalance) {
        super(accountNumber, holderName, email, phone, initialBalance);
    }

    public FixedDepositAccount() {}

    @Override
    public void withdraw(double amount) {
        throw new UnsupportedOperationException(
            "Withdrawals are not permitted on Fixed Deposit accounts.");
    }

    @Override public double getInterestRate()    { return INTEREST_RATE; }
    @Override public double getMinimumBalance()  { return MINIMUM_BALANCE; }
    @Override public String getAccountTypeName() { return "FIXED_DEPOSIT"; }
}
