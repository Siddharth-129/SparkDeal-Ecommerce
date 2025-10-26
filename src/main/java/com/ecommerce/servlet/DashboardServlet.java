package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDao;
import com.ecommerce.dao.CategoryDao;
import com.ecommerce.model.Product;
import com.ecommerce.model.Category;
import com.ecommerce.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private ProductDao productDao;
    private CategoryDao categoryDao;

    @Override
    public void init() throws ServletException {
        super.init();
        productDao = new ProductDao();
        categoryDao = new CategoryDao();
        System.out.println("✅ DashboardServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        System.out.println("🔍 DashboardServlet: doGet called");
        
        // Check authentication
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            System.out.println("❌ User not authenticated, redirecting to login");
            resp.sendRedirect("login.jsp?error=loginRequired");
            return;
        }

        String userName = (String) session.getAttribute("userName");
        System.out.println("✅ User authenticated: " + userName);

        List<Category> categories = new ArrayList<>();
        List<Product> products = new ArrayList<>();
        List<Product> recentProducts = new ArrayList<>();
        String errorMessage = null;

        // Check if database driver is loaded
        if (!DBConnection.isDriverLoaded()) {
            errorMessage = "Database configuration error: " + DBConnection.getDriverError();
            System.err.println("❌ " + errorMessage);
        } else {
            try {
                System.out.println("🔍 Loading dashboard data...");
                
                // Get categories and products from database
                categories = categoryDao.getAllCategories();
                products = productDao.getAllProducts();
                
                // Get recent products (last 8)
                if (products != null && products.size() > 0) {
                    int limit = Math.min(8, products.size());
                    recentProducts = products.subList(0, limit);
                }
                
                // Handle null results
                if (categories == null) {
                    categories = new ArrayList<>();
                }
                if (products == null) {
                    products = new ArrayList<>();
                }
                
                System.out.println("✅ Loaded " + categories.size() + " categories");
                System.out.println("✅ Loaded " + products.size() + " products");
                System.out.println("✅ Recent products: " + recentProducts.size());
                
            } catch (Exception e) {
                // Log the error
                System.err.println("❌ Error loading dashboard data: " + e.getMessage());
                e.printStackTrace();
                
                // Set empty lists to prevent null pointer exceptions in JSP
                categories = new ArrayList<>();
                products = new ArrayList<>();
                recentProducts = new ArrayList<>();
                
                errorMessage = "Unable to load dashboard data. Please try again.";
            }
        }

        // Set attributes for JSP
        req.setAttribute("categories", categories);
        req.setAttribute("products", products);
        req.setAttribute("recentProducts", recentProducts);
        req.setAttribute("user", userName);
        req.setAttribute("totalProducts", products.size());
        req.setAttribute("totalCategories", categories.size());
        
        if (errorMessage != null) {
            req.setAttribute("error", errorMessage);
        }
        
        System.out.println("🔍 Forwarding to dashboard.jsp");
        
        // Forward to dashboard page
        req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("🔍 DashboardServlet: doPost called, redirecting to GET");
        resp.sendRedirect("dashboard");
    }
}
