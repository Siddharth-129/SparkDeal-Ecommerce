package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDao;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductDao productDao;

    @Override
    public void init() throws ServletException {
        productDao = new ProductDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            resp.sendRedirect("login.jsp?error=loginRequired&redirect=cart");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Calculate totals
        double totalPrice = cart.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
        int totalItems = cart.stream().mapToInt(CartItem::getQuantity).sum();

        req.setAttribute("cart", cart);
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("totalItems", totalItems);

        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            resp.sendRedirect("login.jsp?error=loginRequired&redirect=cart");
            return;
        }

        String action = req.getParameter("action");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                Product product = productDao.getProductById(productId);
                if (product != null) {
                    boolean found = false;
                    for (CartItem item : cart) {
                        if (item.getProduct().getId() == productId) {
                            item.setQuantity(item.getQuantity() + 1);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        cart.add(new CartItem(product, 1));
                    }
                    session.setAttribute("successMessage", "Product added to cart successfully!");
                }
            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cart.removeIf(item -> item.getProduct().getId() == productId);
                session.setAttribute("successMessage", "Product removed from cart!");
            } else if ("update".equals(action)) {
                String[] productIds = req.getParameterValues("productId");
                String[] quantities = req.getParameterValues("quantity");
                
                if (productIds != null && quantities != null) {
                    for (int i = 0; i < productIds.length; i++) {
                        int productId = Integer.parseInt(productIds[i]);
                        int quantity = Integer.parseInt(quantities[i]);
                        
                        if (quantity <= 0) {
                            cart.removeIf(item -> item.getProduct().getId() == productId);
                        } else {
                            for (CartItem item : cart) {
                                if (item.getProduct().getId() == productId) {
                                    item.setQuantity(quantity);
                                    break;
                                }
                            }
                        }
                    }
                }
                session.setAttribute("successMessage", "Cart updated successfully!");
            } else if ("clear".equals(action)) {
                cart.clear();
                session.setAttribute("successMessage", "Cart cleared!");
            }

            session.setAttribute("cart", cart);
            resp.sendRedirect("cart");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect("cart?error=invalidInput");
        }
    }
}
