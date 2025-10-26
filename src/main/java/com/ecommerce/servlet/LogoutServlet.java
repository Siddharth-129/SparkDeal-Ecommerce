package com.ecommerce.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if(session != null) {
            session.invalidate();  // Invalidate the session to log out user
        }
        resp.sendRedirect("login.jsp?logout=true");  // Redirect to login page with logout message
    }
}
