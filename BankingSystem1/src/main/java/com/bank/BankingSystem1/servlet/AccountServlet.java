package com.bank.BankingSystem1.servlet;

//package com.bank.BankingSystem.servlet;
//
//import com.bank.BankingSystem.model.BankAccount;
//import com.bank.BankingSystem.service.BankingService;
//import com.bank.BankingSystem.util.AccountFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bank.BankingSystem1.model.BankAccount;
import com.bank.BankingSystem1.service.BankingService;
import com.bank.BankingSystem1.util.AccountFactory;

import java.io.IOException;
import java.util.List;

/**
 * Servlet handling all Account-related HTTP requests.
 *
 * URL pattern: /accounts
 * Uses action parameter to dispatch to specific operations.
 */
@WebServlet("/accounts")
public class AccountServlet extends HttpServlet {

    private final BankingService bankingService = new BankingService();

    // ── GET – display forms / account lists ──────────────────────────────────

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("/WEB-INF/jsp/account-form.jsp").forward(req, resp);
                break;

            case "view":
                viewAccount(req, resp);
                break;

            case "edit":
                editAccountForm(req, resp);
                break;

            case "list":
            default:
                listAccounts(req, resp);
                break;
        }
    }

    // ── POST – process form submissions ──────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                createAccount(req, resp);
                break;

            case "update":
                updateAccount(req, resp);
                break;

            case "close":
                closeAccount(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/accounts");
        }
    }

    // ── Handlers ─────────────────────────────────────────────────────────────

    private void listAccounts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<BankAccount> accounts = bankingService.getAllAccounts();
            req.setAttribute("accounts", accounts);
            req.getRequestDispatcher("/WEB-INF/jsp/account-list.jsp").forward(req, resp);
        } catch (Exception e) {
            handleError(req, resp, e.getMessage());
        }
    }

    private void viewAccount(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            BankAccount account = bankingService.getAccount(accountNumber);
            req.setAttribute("account", account);
            req.getRequestDispatcher("/WEB-INF/jsp/account-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            handleError(req, resp, e.getMessage());
        }
    }

    private void editAccountForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            BankAccount account = bankingService.getAccount(accountNumber);
            req.setAttribute("account", account);
            req.getRequestDispatcher("/WEB-INF/jsp/account-form.jsp").forward(req, resp);
        } catch (Exception e) {
            handleError(req, resp, e.getMessage());
        }
    }

    private void createAccount(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String typeName      = req.getParameter("accountType");
            String holderName    = req.getParameter("holderName");
            String email         = req.getParameter("email");
            String phone         = req.getParameter("phone");
            double initialBalance= Double.parseDouble(req.getParameter("initialBalance"));

            String accountNumber = bankingService.generateAccountNumber();
            BankAccount account  = AccountFactory.create(typeName, accountNumber,
                                        holderName, email, phone, initialBalance);

            bankingService.createAccount(account);

            req.getSession().setAttribute("successMessage",
                "Account created successfully! Account Number: " + accountNumber);
            resp.sendRedirect(req.getContextPath() + "/accounts");

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/account-form.jsp").forward(req, resp);
        }
    }

    private void updateAccount(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String accountNumber = req.getParameter("accountNumber");
            BankAccount account  = bankingService.getAccount(accountNumber);
            account.setHolderName(req.getParameter("holderName"));
            account.setEmail(req.getParameter("email"));
            account.setPhone(req.getParameter("phone"));
            bankingService.updateAccount(account);

            req.getSession().setAttribute("successMessage", "Account updated successfully.");
            resp.sendRedirect(req.getContextPath() + "/accounts?action=view&accountNumber=" + accountNumber);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/account-form.jsp").forward(req, resp);
        }
    }

    private void closeAccount(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accountNumber = req.getParameter("accountNumber");
        try {
            bankingService.closeAccount(accountNumber);
            req.getSession().setAttribute("successMessage",
                "Account " + accountNumber + " has been closed.");
            resp.sendRedirect(req.getContextPath() + "/accounts");
        } catch (Exception e) {
            handleError(req, resp, e.getMessage());
        }
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(req, resp);
    }
}
