package com.ecommerce.test;

import com.ecommerce.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DatabaseTest {
    public static void main(String[] args) {
        System.out.println("🔍 Testing Database Connection...");
        
        // Test 1: Driver loading
        if (DBConnection.isDriverLoaded()) {
            System.out.println("✅ Driver loaded successfully");
        } else {
            System.err.println("❌ Driver not loaded: " + DBConnection.getDriverError());
            return;
        }
        
        // Test 2: Connection
        try {
            DBConnection.testConnection();
        } catch (Exception e) {
            System.err.println("❌ Connection test failed");
            return;
        }
        
        // Test 3: Query products
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) as count FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("count");
                System.out.println("✅ Found " + count + " products in database");
                
                if (count > 0) {
                    // Show first few products
                    String sql2 = "SELECT id, name, price FROM products LIMIT 5";
                    PreparedStatement ps2 = conn.prepareStatement(sql2);
                    ResultSet rs2 = ps2.executeQuery();
                    
                    System.out.println("📋 Sample products:");
                    while (rs2.next()) {
                        System.out.println("  - " + rs2.getString("name") + " ($" + rs2.getDouble("price") + ")");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("❌ Query failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
