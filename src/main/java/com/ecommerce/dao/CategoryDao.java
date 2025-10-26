package com.ecommerce.dao;

import com.ecommerce.model.Category;
import com.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public List<Category> getAllCategories() {
        String sql = "SELECT id, name, description FROM categories ORDER BY name";
        List<Category> list = new ArrayList<>();
        
        System.out.println("🔍 CategoryDao: Attempting to get all categories...");
        
        // Check if database driver is available
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return list;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            System.out.println("✅ Database connection successful, executing categories query...");
            
            while (rs.next()) {
                Category category = new Category(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description")
                );
                list.add(category);
            }
            
            System.out.println("✅ Total categories loaded: " + list.size());
            
        } catch (SQLException e) {
            System.err.println("❌ Database error in getAllCategories: " + e.getMessage());
            e.printStackTrace();
        }
        
        return list;
    }

    public Category getCategoryById(int id) {
        String sql = "SELECT id, name, description FROM categories WHERE id = ?";
        
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return null;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Database error in getCategoryById: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }

    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        
        if (!DBConnection.isDriverLoaded()) {
            System.err.println("❌ Database driver not loaded: " + DBConnection.getDriverError());
            return false;
        }
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            
            boolean result = ps.executeUpdate() == 1;
            System.out.println(result ? "✅ Category added successfully" : "❌ Failed to add category");
            return result;
            
        } catch (SQLException e) {
            System.err.println("❌ Database error in addCategory: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
