package com.bank.BankingSystem1.servlet;

//package com.bank.BankingSystem.servlet;
//
//import com.bank.BankingSystem.model.Transaction;
//import com.bank.BankingSystem.service.BankingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.BankingSystem1.model.Transaction;
import com.bank.BankingSystem1.service.BankingService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet handling all Transaction operations.
 *
 * URL pattern: /transactions
 */
@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {

    private final BankingService bankingService = new BankingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "history";

        switch (action) {
            case "deposit":
            case "withdraw":
            case "transfer":
                showTransactionForm(req, resp, action);
                break;

            case "mini":
                miniStatement(req, resp);
                break;

            case "history":
            default:
                transactionHistory(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "deposit":
                deposit(req, resp);
                break;
            case "withdraw":
                withdraw(req, resp);
                break;
            case "transfer":
                transfer(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/accounts");
        }
    }

    // ── Handlers ─────────────────────────────────────────────────────────────

    private void showTransactionForm(HttpServletRequest req, HttpServletResponse resp,
                                     String action) throws ServletException, IOException {
        req.setAttribute("transactionAction", action);
        req.getRequestDispatcher("/WEB-INF/jsp/transaction-form.jsp").forward(req, resp);
    }

    private void deposit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            double amount  = Double.parseDouble(req.getParameter("amount"));
            double balance = bankingService.deposit(accountNumber, amount);
            req.getSession().setAttribute("successMessage",
                String.format("Deposit of ₹%.2f successful. New balance: ₹%.2f", amount, balance));
            resp.sendRedirect(req.getContextPath() + "/accounts?action=view&accountNumber=" + accountNumber);
        } catch (Exception e) {
            req.setAttribute("transactionAction", "deposit");
            req.setAttribute("error", e.getMessage());
            req.setAttribute("prefillAccount", accountNumber);
            req.getRequestDispatcher("/WEB-INF/jsp/transaction-form.jsp").forward(req, resp);
        }
    }

    private void withdraw(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            double amount  = Double.parseDouble(req.getParameter("amount"));
            double balance = bankingService.withdraw(accountNumber, amount);
            req.getSession().setAttribute("successMessage",
                String.format("Withdrawal of ₹%.2f successful. New balance: ₹%.2f", amount, balance));
            resp.sendRedirect(req.getContextPath() + "/accounts?action=view&accountNumber=" + accountNumber);
        } catch (Exception e) {
            req.setAttribute("transactionAction", "withdraw");
            req.setAttribute("error", e.getMessage());
            req.setAttribute("prefillAccount", accountNumber);
            req.getRequestDispatcher("/WEB-INF/jsp/transaction-form.jsp").forward(req, resp);
        }
    }

    private void transfer(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String fromAccount = req.getParameter("fromAccount");
        try {
            String toAccount = req.getParameter("toAccount");
            double amount    = Double.parseDouble(req.getParameter("amount"));
            bankingService.transfer(fromAccount, toAccount, amount);
            req.getSession().setAttribute("successMessage",
                String.format("Transfer of ₹%.2f from %s to %s successful.", amount, fromAccount, toAccount));
            resp.sendRedirect(req.getContextPath() + "/accounts?action=view&accountNumber=" + fromAccount);
        } catch (Exception e) {
            req.setAttribute("transactionAction", "transfer");
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/transaction-form.jsp").forward(req, resp);
        }
    }

    private void transactionHistory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            List<Transaction> transactions = bankingService.getTransactionHistory(accountNumber);
            req.setAttribute("transactions", transactions);
            req.setAttribute("accountNumber", accountNumber);
            req.getRequestDispatcher("/WEB-INF/jsp/transaction-history.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
        }
    }

    private void miniStatement(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            List<Transaction> transactions = bankingService.getMiniStatement(accountNumber);
            req.setAttribute("transactions", transactions);
            req.setAttribute("accountNumber", accountNumber);
            req.setAttribute("mini", true);
            req.getRequestDispatcher("/WEB-INF/jsp/transaction-history.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
        }
    }
}