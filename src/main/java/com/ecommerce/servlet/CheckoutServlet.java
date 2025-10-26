package com.ecommerce.servlet;

import com.ecommerce.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            resp.sendRedirect("login.jsp?error=loginRequired&redirect=checkout");
            return;
        }

        // Check if cart is not empty
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("cart?error=emptyCart");
            return;
        }

        // Calculate totals
        double totalPrice = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
        int totalItems = cart.stream().mapToInt(CartItem::getQuantity).sum();
        double shipping = totalPrice > 50 ? 0 : 5.99;
        double tax = totalPrice * 0.08; // 8% tax
        double finalTotal = totalPrice + shipping + tax;

        req.setAttribute("cart", cart);
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("shipping", shipping);
        req.setAttribute("tax", tax);
        req.setAttribute("finalTotal", finalTotal);

        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            resp.sendRedirect("login.jsp?error=loginRequired");
            return;
        }

        // Process order
        String orderNumber = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        
        // Get order details
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double totalPrice = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
        double shipping = totalPrice > 50 ? 0 : 5.99;
        double tax = totalPrice * 0.08;
        double finalTotal = totalPrice + shipping + tax;

        // Store order details in session (in real app, save to database)
        session.setAttribute("orderNumber", orderNumber);
        session.setAttribute("orderTotal", finalTotal);
        session.setAttribute("orderItems", cart.size());
        
        // Clear cart after successful order
        session.removeAttribute("cart");
        
        resp.sendRedirect("order-confirmation");
    }
}
