<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Shopping Cart - SparkDeal</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<style>
    :root {
        --primary: #6366f1;
        --primary-dark: #4f46e5;
        --accent: #8b5cf6;
        --secondary: #f59e0b;
        --dark: #1f2937;
        --light: #6b7280;
        --bg: #f8fafc;
        --card: #ffffff;
        --shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        --gradient: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
    }

    *, *::before, *::after {
      box-sizing: border-box;
    }
    body {
      font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
      margin: 0;
      background: linear-gradient(135deg, #f8f9ff 0%, #f0f4ff 100%);
      color: var(--dark);
      line-height: 1.6;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }
    a {
      text-decoration: none;
      color: var(--primary);
      transition: all 0.3s ease;
    }
    a:hover {
      color: var(--primary-dark);
    }

    /* Navbar */
    header.navbar {
      background: var(--gradient);
      color: white;
      padding: 1rem 2rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: sticky;
      top: 0;
      z-index: 1000;
      box-shadow: 0 4px 20px rgba(99, 102, 241, 0.3);
    }
    .navbar .logo {
      font-size: 2rem;
      font-weight: 800;
      display: flex;
      align-items: center;
      gap: 0.8rem;
      user-select: none;
    }
    .navbar .logo i {
      color: white;
    }
    .navbar nav {
      display: flex;
      align-items: center;
      gap: 2rem;
    }
    .navbar nav a {
      color: white;
      font-weight: 600;
      font-size: 1rem;
      padding: 0.8rem 1.2rem;
      border-radius: 12px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }
    .navbar nav a::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.2);
      transition: left 0.3s ease;
    }
    .navbar nav a:hover::before,
    .navbar nav a.active::before {
      left: 0;
    }
    .navbar nav a:hover,
    .navbar nav a.active {
      background: rgba(255, 255, 255, 0.1);
      transform: translateY(-2px);
    }
    .navbar .logout-btn {
      background: transparent;
      border: 2px solid white;
      color: white;
      padding: 0.6rem 1.2rem;
      border-radius: 10px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.3s ease;
    }
    .navbar .logout-btn:hover {
      background: white;
      color: var(--primary);
      transform: translateY(-2px);
    }

    /* Main content container */
    main.container {
      max-width: 1200px;
      margin: 3rem auto;
      padding: 0 2rem;
      background: var(--card);
      border-radius: 20px;
      box-shadow: var(--shadow);
      flex-grow: 1;
      border: 1px solid rgba(99, 102, 241, 0.1);
    }
    main.container h1 {
      font-size: 2.8rem;
      font-weight: 800;
      margin-bottom: 2rem;
      background: var(--gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-align: center;
      user-select: none;
    }

    /* Cart Table */
    table.cart {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 2rem;
      font-size: 1rem;
      border-radius: 16px;
      overflow: hidden;
    }
    table.cart th, table.cart td {
      padding: 1.5rem 1rem;
      border-bottom: 1px solid rgba(99, 102, 241, 0.1);
      vertical-align: middle;
      text-align: center;
    }
    table.cart th {
      background: var(--gradient);
      color: white;
      font-weight: 700;
      text-transform: uppercase;
      user-select: none;
      font-size: 0.9rem;
      letter-spacing: 0.5px;
    }
    table.cart tr:hover {
      background: rgba(99, 102, 241, 0.02);
    }
    .product-cell {
      display: flex;
      align-items: center;
      gap: 1.5rem;
      text-align: left;
      font-weight: 600;
    }
    .product-image {
      width: 100px;
      height: 100px;
      border-radius: 16px;
      object-fit: cover;
      box-shadow: var(--shadow);
      transition: transform 0.3s ease;
    }
    .product-cell:hover .product-image {
      transform: scale(1.05);
    }
    .product-name {
      font-weight: 700;
      color: var(--dark);
      margin-bottom: 0.5rem;
    }
    .product-description {
      font-size: 0.9rem;
      color: var(--light);
      line-height: 1.4;
    }

    /* Quantity Controls */
    .quantity-controls {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 1rem;
      user-select: none;
    }
    .quantity-btn {
      padding: 0.8rem 1rem;
      background: var(--bg);
      border: 2px solid var(--primary);
      cursor: pointer;
      border-radius: 10px;
      font-size: 1.1rem;
      font-weight: 700;
      color: var(--primary);
      transition: all 0.3s ease;
      min-width: 45px;
    }
    .quantity-btn:hover {
      background: var(--primary);
      color: white;
      transform: scale(1.1);
    }
    .quantity-input {
      width: 70px;
      text-align: center;
      padding: 0.8rem;
      font-size: 1.1rem;
      border: 2px solid var(--primary);
      border-radius: 10px;
      color: var(--dark);
      font-weight: 600;
      background: var(--bg);
    }

    /* Remove Button */
    .remove-btn {
      background: transparent;
      border: 2px solid #ef4444;
      color: #ef4444;
      padding: 0.8rem 1rem;
      border-radius: 10px;
      font-size: 1.1rem;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    .remove-btn:hover {
      background: #ef4444;
      color: white;
      transform: scale(1.1);
    }

    /* Order Summary */
    .summary {
      border-top: 2px solid rgba(99, 102, 241, 0.1);
      padding-top: 2.5rem;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      flex-wrap: wrap;
      gap: 2rem;
    }
    .summary-right {
      flex: 1;
      max-width: 400px;
      background: var(--card);
      border-radius: 20px;
      padding: 2rem;
      box-shadow: var(--shadow);
      border: 1px solid rgba(99, 102, 241, 0.1);
    }
    .summary-right h2 {
      margin-bottom: 1.5rem;
      font-size: 1.8rem;
      font-weight: 800;
      background: var(--gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .summary-item {
      display: flex;
      justify-content: space-between;
      font-weight: 600;
      font-size: 1.1rem;
      margin-bottom: 1rem;
      padding-bottom: 0.5rem;
      border-bottom: 1px solid rgba(99, 102, 241, 0.1);
    }
    .summary-total {
      font-size: 1.4rem;
      font-weight: 800;
      color: var(--primary);
      border-top: 2px solid var(--primary);
      padding-top: 1rem;
      margin-top: 1rem;
    }
    .btn-checkout {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.8rem;
      width: 100%;
      background: var(--gradient);
      color: white;
      border: none;
      padding: 1.2rem 0;
      font-size: 1.2rem;
      font-weight: 700;
      border-radius: 14px;
      cursor: pointer;
      box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
      text-decoration: none;
      transition: all 0.3s ease;
      margin-top: 1.5rem;
    }
    .btn-checkout:hover {
      transform: translateY(-3px);
      box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
    }

    /* Promo code */
    .promo-code {
      margin-top: 1.5rem;
      display: flex;
      gap: 1rem;
      align-items: center;
    }
    .promo-code input[type="text"] {
      flex-grow: 1;
      padding: 1rem 1.2rem;
      font-size: 1rem;
      border: 2px solid var(--primary);
      border-radius: 12px;
      color: var(--dark);
      font-weight: 600;
      background: var(--bg);
      transition: all 0.3s ease;
    }
    .promo-code input[type="text"]:focus {
      outline: none;
      border-color: var(--accent);
      box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }
    .promo-code button {
      padding: 1rem 2rem;
      background: var(--primary);
      border: none;
      color: white;
      font-weight: 700;
      border-radius: 12px;
      cursor: pointer;
      transition: all 0.3s ease;
    }
    .promo-code button:hover {
      background: var(--primary-dark);
      transform: translateY(-2px);
    }

    /* Continue Shopping */
    .continue-shopping {
      display: inline-flex;
      align-items: center;
      gap: 0.8rem;
      margin-bottom: 2rem;
      font-weight: 700;
      color: var(--primary);
      cursor: pointer;
      padding: 1rem 1.5rem;
      border-radius: 12px;
      background: var(--bg);
      transition: all 0.3s ease;
    }
    .continue-shopping:hover {
      background: var(--primary);
      color: white;
      transform: translateX(-5px);
    }

    /* Empty Cart */
    .empty-cart {
      text-align: center;
      padding: 6rem 2rem;
      background: var(--card);
      border-radius: 20px;
      box-shadow: var(--shadow);
      margin: 2rem 0;
    }
    .empty-icon {
      font-size: 5rem;
      margin-bottom: 2rem;
      background: var(--gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .empty-title {
      font-size: 2rem;
      font-weight: 800;
      color: var(--dark);
      margin-bottom: 1rem;
    }
    .empty-message {
      color: var(--light);
      font-size: 1.1rem;
      margin-bottom: 2rem;
    }
    .empty-cart .btn-primary {
      background: var(--gradient);
      color: white;
      padding: 1.2rem 2.5rem;
      border-radius: 12px;
      font-weight: 700;
      text-decoration: none;
      transition: all 0.3s ease;
    }
    .empty-cart .btn-primary:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3);
    }

    /* Update Cart Button */
    .update-cart-btn {
      background: var(--gradient);
      color: white;
      border: none;
      padding: 1.2rem 2.5rem;
      border-radius: 12px;
      font-weight: 700;
      cursor: pointer;
      margin-bottom: 2rem;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.8rem;
    }
    .update-cart-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3);
    }

    /* Clear Cart Button */
    .clear-cart-btn {
      background: transparent;
      border: 2px solid #ef4444;
      color: #ef4444;
      padding: 1rem 2rem;
      border-radius: 12px;
      font-weight: 700;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.8rem;
      margin-top: 2rem;
    }
    .clear-cart-btn:hover {
      background: #ef4444;
      color: white;
      transform: translateY(-2px);
    }

    /* Footer */
    footer.footer {
      background: var(--dark);
      color: #d1d5db;
      padding: 3rem 2rem;
      margin-top: auto;
    }
    .footer .container {
      max-width: 1200px;
      margin: auto;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 3rem;
    }
    .footer-section h3 {
      color: white;
      margin-bottom: 1.5rem;
      font-weight: 700;
      font-size: 1.2rem;
    }
    .footer-section ul {
      list-style: none;
      padding: 0;
    }
    .footer-section ul li {
      margin-bottom: 0.8rem;
    }
    .footer-section ul li a {
      color: #9ca3af;
      transition: color 0.3s ease;
    }
    .footer-section ul li a:hover {
      color: white;
    }
    .footer-bottom {
      text-align: center;
      margin-top: 3rem;
      color: #9ca3af;
      font-size: 0.9rem;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .navbar {
        padding: 1rem;
        flex-direction: column;
        gap: 1rem;
      }
      .navbar nav {
        gap: 1rem;
      }
      main.container {
        margin: 1rem;
        padding: 1.5rem;
        border-radius: 16px;
      }
      table.cart {
        font-size: 0.9rem;
      }
      .product-cell {
        flex-direction: column;
        text-align: center;
        gap: 1rem;
      }
      .summary {
        flex-direction: column;
      }
      .summary-right {
        max-width: 100%;
      }
    }

    /* Animation classes */
    .fade-in {
      opacity: 0;
      animation: fadeInUp 0.6s ease forwards;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
</style>
</head>
<body>
<header class="navbar">
    <div class="logo">
        <i class="fas fa-bolt"></i> SparkDeal
    </div>
    <nav>
        <a href="home">Home</a>
        <a href="products">Products</a>
        <a href="cart" class="active">Cart</a>
        <c:choose>
            <c:when test="${not empty sessionScope.userName}">
                <a href="dashboard">Dashboard</a>
                <form action="logout" method="get" style="display:inline;">
                    <button type="submit" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="login.jsp">Login</a>
                <a href="signup.jsp">Sign Up</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>

<main class="container">
    <a href="products" class="continue-shopping fade-in">
        <i class="fas fa-arrow-left"></i> Continue Shopping
    </a>
    <h1 class="fade-in">Your Shopping Cart</h1>

    <c:choose>
        <c:when test="${empty cart}">
            <section class="empty-cart fade-in">
                <i class="fas fa-shopping-cart empty-icon"></i>
                <h2 class="empty-title">Your cart is empty</h2>
                <p class="empty-message">Browse products to add items to your cart</p>
                <a href="products" class="btn-primary">Start Shopping</a>
            </section>
        </c:when>
        <c:otherwise>
            <form action="cart" method="post" id="cartForm" class="fade-in">
                <input type="hidden" name="action" value="update" />
                <table class="cart">
                    <thead>
                        <tr>
                            <th scope="col">Product</th>
                            <th scope="col">Price (₹)</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Subtotal (₹)</th>
                            <th scope="col">Remove</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart}">
                            <tr class="fade-in">
                                <td class="product-cell">
                                    <img src="${item.product.imageUrl}" alt="${item.product.name}" class="product-image" onerror="this.src='https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400';" />
                                    <div class="product-name-description">
                                        <div class="product-name">${item.product.name}</div>
                                        <div class="product-description">${item.product.description}</div>
                                    </div>
                                </td>
                                <td>₹<fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td>
                                    <div class="quantity-controls">
                                        <button type="button" class="quantity-btn" onclick="changeQuantity(this, -1)">-</button>
                                        <input type="number" name="quantity" class="quantity-input" min="1" value="${item.quantity}" />
                                        <button type="button" class="quantity-btn" onclick="changeQuantity(this, 1)">+</button>
                                        <input type="hidden" name="productId" value="${item.product.id}" />
                                    </div>
                                </td>
                                <td>₹<fmt:formatNumber value="${item.product.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td>
                                    <form action="cart" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="remove" />
                                        <input type="hidden" name="productId" value="${item.product.id}" />
                                        <button type="submit" class="remove-btn" title="Remove item">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <button type="submit" class="update-cart-btn">
                    <i class="fas fa-sync-alt"></i> Update Cart
                </button>
            </form>

            <section class="summary fade-in">
                <div class="summary-left"></div>
                <article class="summary-right">
                    <h2>Order Summary</h2>
                    <div class="summary-item"><span>Total Items:</span><span><c:out value="${totalItems}"/></span></div>
                    <div class="summary-item"><span>Total Price:</span> 
                        <span>₹<fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                    </div>
                    <div class="promo-code">
                        <input type="text" name="promoCode" placeholder="Promo code" />
                        <button type="button" onclick="alert('Promo code functionality coming soon!')">Apply</button>
                    </div>
                    
                    <a href="checkout" class="btn-checkout">
                        <i class="fas fa-credit-card"></i> Proceed to Checkout
                    </a>
                </article>
            </section>

            <form action="cart" method="post" class="fade-in">
                <input type="hidden" name="action" value="clear" />
                <button type="submit" class="clear-cart-btn">
                    <i class="fas fa-trash-alt"></i> Clear Cart
                </button>
            </form>
        </c:otherwise>
    </c:choose>
</main>

<footer class="footer">
    <div class="container">
        <section class="footer-section">
            <h3>Customer Service</h3>
            <ul>
                <li><a href="contact.jsp">Contact Us</a></li>
                <li><a href="#">Returns & Refunds</a></li>
                <li><a href="#">Shipping Info</a></li>
            </ul>
        </section>
        <section class="footer-section">
            <h3>About Us</h3>
            <ul>
                <li><a href="#">Our Story</a></li>
                <li><a href="#">Careers</a></li>
                <li><a href="#">Affiliate Program</a></li>
            </ul>
        </section>
        <section class="footer-section">
            <h3>Connect</h3>
            <ul>
                <li><a href="#"><i class="fab fa-facebook"></i> Facebook</a></li>
                <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
                <li><a href="#"><i class="fab fa-instagram"></i> Instagram</a></li>
            </ul>
        </section>
    </div>
    <div class="footer-bottom">
      &copy; 2025 SparkDeal. All rights reserved.
    </div>
</footer>

<script>
function changeQuantity(button, delta) {
    const input = button.parentElement.querySelector('input[name="quantity"]');
    let currentVal = parseInt(input.value);
    if (isNaN(currentVal)) currentVal = 1;
    let newVal = currentVal + delta;
    if (newVal < 1) newVal = 1;
    input.value = newVal;
}

// Add staggered animations
document.addEventListener('DOMContentLoaded', () => {
    const fadeElements = document.querySelectorAll('.fade-in');
    fadeElements.forEach((el, index) => {
        el.style.animationDelay = `${index * 0.1}s`;
    });
});
</script>
</body>
</html>