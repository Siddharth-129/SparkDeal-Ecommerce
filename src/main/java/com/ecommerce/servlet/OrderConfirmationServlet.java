package com.ecommerce.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            resp.sendRedirect("login.jsp?error=loginRequired");
            return;
        }

        // Check if there's an order to confirm
        String orderNumber = (String) session.getAttribute("orderNumber");
        if (orderNumber == null) {
            resp.sendRedirect("products");
            return;
        }

        req.getRequestDispatcher("order-confirmation.jsp").forward(req, resp);
    }
}
