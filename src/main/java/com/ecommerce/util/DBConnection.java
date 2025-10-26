package com.ecommerce.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Updated to point to your "test" database
    private static final String URL = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC"; 
    private static final String USER = "root"; 
    private static final String PASSWORD = "Sidhu@129"; 
    
    private static boolean driverLoaded = false;
    private static String driverError = null;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            driverLoaded = true;
            System.out.println("✅ MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            driverLoaded = false;
            driverError = "MySQL JDBC Driver not found. Please add mysql-connector-j.jar to your classpath.";
            System.err.println("❌ " + driverError);
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (!driverLoaded) {
            throw new SQLException(driverError != null ? driverError : "Database driver not available");
        }
        
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database connection established to: " + URL);
            return conn;
        } catch (SQLException e) {
            System.err.println("❌ Failed to connect to database: " + e.getMessage());
            System.err.println("❌ URL: " + URL);
            System.err.println("❌ User: " + USER);
            throw e;
        }
    }
    
    public static boolean isDriverLoaded() {
        return driverLoaded;
    }
    
    public static String getDriverError() {
        return driverError;
    }
    
    // Test method to verify connection
    public static void testConnection() {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("✅ Database connection test successful!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("❌ Database connection test failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
