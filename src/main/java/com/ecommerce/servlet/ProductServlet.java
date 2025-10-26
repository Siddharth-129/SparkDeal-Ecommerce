package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDao;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDao productDao;

    @Override
    public void init() throws ServletException {
        super.init();
        productDao = new ProductDao();
        System.out.println("✅ ProductServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        System.out.println("🔍 ProductServlet: doGet called");
        
        List<Product> products = new ArrayList<>();
        String errorMessage = null;
        
        // Check if database driver is loaded
        if (!DBConnection.isDriverLoaded()) {
            errorMessage = "Database configuration error: " + DBConnection.getDriverError();
            System.err.println("❌ " + errorMessage);
        } else {
            try {
                System.out.println("🔍 Calling ProductDao.getAllProducts()...");
                products = productDao.getAllProducts();
                
                if (products == null) {
                    products = new ArrayList<>();
                    System.err.println("❌ ProductDao returned null");
                }
                
                System.out.println("✅ ProductServlet loaded " + products.size() + " products");
                
                // Debug: Print first few products
                for (int i = 0; i < Math.min(3, products.size()); i++) {
                    Product p = products.get(i);
                    System.out.println("✅ Product " + (i+1) + ": " + p.getName() + " - $" + p.getPrice());
                }
                
            } catch (Exception e) {
                System.err.println("❌ Error in ProductServlet: " + e.getMessage());
                e.printStackTrace();
                
                products = new ArrayList<>();
                errorMessage = "Unable to load products from database. Error: " + e.getMessage();
            }
        }

        // Set attributes for JSP
        req.setAttribute("products", products);
        req.setAttribute("totalProducts", products.size());
        
        if (errorMessage != null) {
            req.setAttribute("error", errorMessage);
        }
        
        System.out.println("🔍 Forwarding to products.jsp with " + products.size() + " products");
        
        // Forward to products page
        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("🔍 ProductServlet: doPost called, redirecting to GET");
        resp.sendRedirect("products");
    }
}
