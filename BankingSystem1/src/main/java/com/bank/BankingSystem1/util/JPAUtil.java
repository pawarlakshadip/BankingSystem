package com.bank.BankingSystem1.util;

//package com.bank.BankingSystem.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * JPA Utility – manages the EntityManagerFactory singleton.
 * Replaces the old JDBC DBConnection singleton.
 *
 * Uses HikariCP connection pool under the hood (configured in persistence.xml),
 * giving us:
 *   - Connection pooling (no more single-connection bottleneck)
 *   - Prepared statement caching
 *   - Automatic reconnection on failure
 */
public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "BankingPU";
    private static EntityManagerFactory emf;

    // Initialised once when the class is first loaded
    static {
        try {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            System.out.println("[JPA] EntityManagerFactory created successfully.");
        } catch (Exception e) {
            System.err.println("[JPA] Failed to create EntityManagerFactory: " + e.getMessage());
            throw new ExceptionInInitializerError(e);
        }
    }

    private JPAUtil() {}

    /**
     * Returns a fresh EntityManager per request / unit of work.
     * The caller is responsible for closing it.
     */
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    /**
     * Close the factory on application shutdown (called from ServletContextListener).
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("[JPA] EntityManagerFactory closed.");
        }
    }
}
