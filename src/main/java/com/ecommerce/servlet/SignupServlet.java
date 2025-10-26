package com.ecommerce.servlet;

import com.ecommerce.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Basic validation
        if (name == null || email == null || password == null || 
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            resp.sendRedirect("signup.jsp?error=emptyfields");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users(name, email, password) VALUES(?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name.trim());
            ps.setString(2, email.trim());
            ps.setString(3, password);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ User registered: " + email);
                resp.sendRedirect("login.jsp?msg=registered");
            } else {
                System.out.println("⚠️ Insert failed for user: " + email);
                resp.sendRedirect("signup.jsp?error=insertfailed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (e.getErrorCode() == 1062) { // Duplicate entry error
                resp.sendRedirect("signup.jsp?error=emailexists");
            } else {
                resp.sendRedirect("signup.jsp?error=dberror");
            }
        }
    }
}
