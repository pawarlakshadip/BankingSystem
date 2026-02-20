package com.bank.BankingSystem1.util;

//package com.bank.BankingSystem.util;

import com.bank.BankingSystem1.model.BankAccount;
import com.bank.BankingSystem1.model.CurrentAccount;
import com.bank.BankingSystem1.model.FixedDepositAccount;
import com.bank.BankingSystem1.model.SavingsAccount;

/**
 * Factory class to instantiate the correct BankAccount subtype based on user choice.
 */
public class AccountFactory {

    public static BankAccount create(int typeChoice, String accountNumber,
                                     String holderName, String email,
                                     String phone, double initialBalance) {
        switch (typeChoice) {
            case 1: return new SavingsAccount(accountNumber, holderName, email, phone, initialBalance);
            case 2: return new CurrentAccount(accountNumber, holderName, email, phone, initialBalance);
            case 3: return new FixedDepositAccount(accountNumber, holderName, email, phone, initialBalance);
            default: throw new IllegalArgumentException("Invalid account type: " + typeChoice);
        }
    }

    public static BankAccount create(String typeName, String accountNumber,
                                     String holderName, String email,
                                     String phone, double initialBalance) {
        switch (typeName.toUpperCase()) {
            case "SAVINGS":       return new SavingsAccount(accountNumber, holderName, email, phone, initialBalance);
            case "CURRENT":       return new CurrentAccount(accountNumber, holderName, email, phone, initialBalance);
            case "FIXED_DEPOSIT": return new FixedDepositAccount(accountNumber, holderName, email, phone, initialBalance);
            default: throw new IllegalArgumentException("Invalid account type: " + typeName);
        }
    }
}