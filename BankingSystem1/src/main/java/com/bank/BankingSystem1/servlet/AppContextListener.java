package com.bank.BankingSystem1.servlet;

import javax.servlet.ServletContextEvent;

//package com.bank.BankingSystem.servlet;
//
//import com.bank.BankingSystem.util.JPAUtil;

//import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.bank.BankingSystem1.util.JPAUtil;

/**
 * Lifecycle listener that manages JPAUtil (EntityManagerFactory) startup and shutdown.
 *
 * On startup: triggers static initializer of JPAUtil → creates the EMF and HikariCP pool.
 * On shutdown: closes the EMF cleanly, releasing all pooled connections.
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Force static init of JPAUtil
        JPAUtil.getEntityManager().close();
        System.out.println("[App] Banking System started. JPA/HikariCP pool ready.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JPAUtil.shutdown();
        System.out.println("[App] Banking System stopped. Resources released.");
    }
}