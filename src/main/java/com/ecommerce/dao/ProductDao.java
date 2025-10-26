package com.ecommerce.dao;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

    public List<Product> getAllProducts() {
        String sql = "SELECT id, name, description, price, image_url FROM products ORDER BY created_at DESC";
        List<Product> list = new ArrayList<>();
        
        System.out.println("🔍 ProductDao: Attempting to get all products...");
        
        // Check if database driver is available
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return list;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            System.out.println("✅ Database connection successful, executing query...");
            
            int count = 0;
            while (rs.next()) {
                Product p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                );
                list.add(p);
                count++;
                
                if (count <= 3) { // Log first 3 products
                    System.out.println("✅ Loaded product: " + p.getName() + " ($" + p.getPrice() + ")");
                }
            }
            
            System.out.println("✅ Total products loaded: " + list.size());
            
        } catch (SQLException e) {
            System.err.println("❌ Database error in getAllProducts: " + e.getMessage());
            System.err.println("❌ SQL State: " + e.getSQLState());
            System.err.println("❌ Error Code: " + e.getErrorCode());
            e.printStackTrace();
        }
        
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT id, name, description, price, image_url FROM products WHERE id = ?";
        
        System.out.println("🔍 ProductDao: Getting product by ID: " + id);
        
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return null;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                    );
                    System.out.println("✅ Retrieved product: " + product.getName());
                    return product;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Database error in getProductById: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("❌ Product not found with ID: " + id);
        return null;
    }

    public boolean addProduct(Product p) {
        String sql = "INSERT INTO products (name, description, price, image_url) VALUES (?, ?, ?, ?)";
        
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return false;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImageUrl());
            
            boolean result = ps.executeUpdate() == 1;
            System.out.println(result ? "✅ Product added successfully: " + p.getName() : "❌ Failed to add product: " + p.getName());
            return result;
            
        } catch (SQLException e) {
            System.err.println("❌ Database error in addProduct: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
