<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Checkout - SparkDeal</title>
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
    background: linear-gradient(135deg, #f8f9ff 0%, #f0f4ff 100%);
    color: var(--dark);
    line-height: 1.6;
    margin: 0;
    min-height: 100vh;
    padding: 2.5rem 1rem;
  }

  .main-wrapper {
    max-width: 1280px;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
    gap: 2.5rem;
    justify-content: center;
  }

  .form-container, .summary-container {
    background: var(--card);
    border-radius: 20px;
    box-shadow: var(--shadow);
    padding: 2.5rem 3rem;
    border: 1px solid rgba(99, 102, 241, 0.1);
    transition: all 0.3s ease;
  }

  .form-container:hover, .summary-container:hover {
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
  }

  .form-container {
    flex: 1 1 55%;
    min-width: 320px;
  }

  .summary-container {
    flex: 1 1 38%;
    min-width: 300px;
  }

  /* Header */
  .checkout-header {
    max-width: 900px;
    margin: 1rem auto 3rem;
    text-align: center;
  }

  .checkout-header h1 {
    font-size: 3rem;
    font-weight: 800;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 1rem;
  }

  .breadcrumbs {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    color: var(--light);
    font-weight: 600;
  }

  .breadcrumbs > div {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.8rem 1.5rem;
    border-radius: 12px;
    transition: all 0.3s ease;
  }

  .breadcrumbs .current {
    background: var(--gradient);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
  }

  /* Form styles */
  .form-section {
    margin-bottom: 2.5rem;
    border-bottom: 2px solid rgba(99, 102, 241, 0.1);
    padding-bottom: 1.5rem;
    position: relative;
  }

  .form-section:last-of-type {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
  }

  .form-section h3 {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--dark);
    margin-bottom: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.8rem;
  }

  .form-section h3 i {
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .field-group {
    margin-bottom: 1.5rem;
    position: relative;
  }

  .field-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.2rem;
  }

  label {
    font-weight: 600;
    font-size: 0.95rem;
    color: var(--light);
    display: block;
    margin-bottom: 0.5rem;
  }

  input[type="text"],
  input[type="email"],
  input[type="tel"] {
    width: 100%;
    padding: 1rem 1.2rem;
    font-size: 1rem;
    border: 2px solid #e5e7eb;
    border-radius: 12px;
    background: var(--bg);
    color: var(--dark);
    font-weight: 500;
    transition: all 0.3s ease;
  }

  input[type="text"]:focus,
  input[type="email"]:focus,
  input[type="tel"]:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    background: white;
    transform: translateY(-2px);
  }

  /* Order summary */
  .summary-container h3 {
    font-size: 1.8rem;
    font-weight: 800;
    margin-bottom: 2rem;
    text-align: center;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .order-item {
    display: flex;
    gap: 1.2rem;
    align-items: center;
    border-bottom: 1px solid rgba(99, 102, 241, 0.1);
    padding: 1.2rem 0;
    transition: all 0.3s ease;
  }

  .order-item:hover {
    transform: translateX(5px);
  }

  .item-image {
    width: 70px;
    height: 70px;
    border-radius: 12px;
    object-fit: cover;
    box-shadow: var(--shadow);
    transition: transform 0.3s ease;
  }

  .order-item:hover .item-image {
    transform: scale(1.05);
  }

  .item-info {
    flex-grow: 1;
  }

  .item-name {
    font-weight: 700;
    font-size: 1rem;
    color: var(--dark);
    margin-bottom: 0.3rem;
  }

  .item-qty {
    color: var(--light);
    font-weight: 600;
    font-size: 0.85rem;
  }

  .item-price {
    font-weight: 800;
    font-size: 1.1rem;
    color: var(--primary);
  }

  /* Summary totals */
  .summary-row {
    display: flex;
    justify-content: space-between;
    font-weight: 600;
    font-size: 1.1rem;
    padding: 1rem 0;
    border-bottom: 1px solid rgba(99, 102, 241, 0.1);
  }

  .summary-total-row {
    display: flex;
    justify-content: space-between;
    font-weight: 800;
    font-size: 1.4rem;
    padding-top: 1.5rem;
    color: var(--primary);
    border-top: 2px solid var(--primary);
  }

  /* Secure note */
  .secure-note {
    font-weight: 600;
    font-size: 0.9rem;
    color: var(--light);
    text-align: center;
    margin-top: 1.5rem;
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    align-items: center;
    padding: 1rem;
    background: rgba(99, 102, 241, 0.05);
    border-radius: 10px;
  }
  .secure-note i {
    color: var(--primary);
  }

  /* Submit button */
  button.btn-checkout {
    width: 100%;
    margin-top: 2rem;
    padding: 1.2rem 0;
    font-size: 1.2rem;
    font-weight: 700;
    background: var(--gradient);
    border: none;
    border-radius: 14px;
    color: white;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }

  button.btn-checkout::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: left 0.5s;
  }

  button.btn-checkout:hover::before {
    left: 100%;
  }

  button.btn-checkout:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
  }

  /* Back link */
  a.back-to-cart {
    display: inline-flex;
    align-items: center;
    gap: 0.8rem;
    font-weight: 600;
    color: var(--primary);
    margin-bottom: 2.8rem;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    background: var(--bg);
    transition: all 0.3s ease;
    text-decoration: none;
  }

  a.back-to-cart:hover {
    background: var(--primary);
    color: white;
    transform: translateX(-5px);
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

  /* Responsive */
  @media (max-width: 900px) {
    .main-wrapper {
      flex-direction: column;
      gap: 2.2rem;
    }
    .form-container, .summary-container {
      flex-basis: 100%;
      padding: 2rem;
    }
    .field-grid {
      grid-template-columns: 1fr;
    }
    .breadcrumbs {
      flex-wrap: wrap;
      gap: 0.8rem;
    }
    .checkout-header h1 {
      font-size: 2.5rem;
    }
  }
</style>
</head>
<body>

<div class="container">

  <a href="cart" class="back-to-cart fade-in">
    <i class="fas fa-arrow-left"></i>Back to Cart
  </a>

  <div class="checkout-header fade-in">
    <h1>Checkout</h1>
    <nav class="breadcrumbs">
      <div><i class="fas fa-shopping-cart"></i> Cart</div>
      <div><i class="fas fa-chevron-right"></i></div>
      <div class="current"><i class="fas fa-credit-card"></i> Checkout</div>
      <div><i class="fas fa-chevron-right"></i></div>
      <div><i class="fas fa-check-circle"></i> Confirmation</div>
    </nav>
  </div>

  <div class="main-wrapper">
    <form action="checkout" method="post" class="form-container fade-in">
      <section class="form-section">
        <h3><i class="fas fa-shipping-fast"></i> Shipping Information</h3>
        <div class="field-grid">
          <div class="field-group">
            <label for="firstName">First Name *</label>
            <input id="firstName" name="firstName" type="text" required />
          </div>
          <div class="field-group">
            <label for="lastName">Last Name *</label>
            <input id="lastName" name="lastName" type="text" required />
          </div>
        </div>
        <div class="field-group">
          <label for="email">Email Address *</label>
          <input id="email" name="email" type="email" value="${sessionScope.userName}" required />
        </div>
        <div class="field-group">
          <label for="phone">Phone Number *</label>
          <input id="phone" name="phone" type="tel" required />
        </div>
        <div class="field-group">
          <label for="address">Address *</label>
          <input id="address" name="address" type="text" required />
        </div>
        <div class="field-grid">
          <div class="field-group">
            <label for="city">City *</label>
            <input id="city" name="city" type="text" required />
          </div>
          <div class="field-group">
            <label for="zipCode">ZIP Code *</label>
            <input id="zipCode" name="zipCode" type="text" required />
          </div>
        </div>
      </section>

      <section class="form-section">
        <h3><i class="fas fa-credit-card"></i> Payment Information</h3>
        <div class="field-group">
          <label for="cardNumber">Card Number *</label>
          <input id="cardNumber" name="cardNumber" type="text" placeholder="1234 5678 9012 3456" required />
        </div>
        <div class="field-grid">
          <div class="field-group">
            <label for="expiryDate">Expiry Date *</label>
            <input id="expiryDate" name="expiryDate" type="text" placeholder="MM/YY" required />
          </div>
          <div class="field-group">
            <label for="cvv">CVV *</label>
            <input id="cvv" name="cvv" type="text" placeholder="123" required />
          </div>
        </div>
        <div class="field-group">
          <label for="cardholderName">Cardholder Name *</label>
          <input id="cardholderName" name="cardholderName" type="text" required />
        </div>
      </section>

      <button type="submit" class="btn-checkout">
        <i class="fas fa-lock"></i> Place Order Securely
      </button>
    </form>

    <section class="summary-container fade-in">
      <h3>Order Summary</h3>
      <c:forEach var="item" items="${cart}">
        <div class="order-item">
          <img src="${item.product.imageUrl}" alt="${item.product.name}" class="item-image" onerror="this.src='https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=400'" />
          <div class="item-info">
            <div class="item-name">${item.product.name}</div>
            <div class="item-qty">Qty: ${item.quantity}</div>
          </div>
          <div class="item-price">₹<fmt:formatNumber value="${item.product.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/></div>
        </div>
      </c:forEach>

      <div class="summary-row"><span>Subtotal (${totalItems})</span><span>₹<fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span></div>
      <div class="summary-row"><span>Shipping</span>
        <span>
          <c:choose>
            <c:when test="${shipping == 0}">
              <span style="color:#10b981;">Free</span>
            </c:when>
            <c:otherwise>₹<fmt:formatNumber value="${shipping}" type="number" minFractionDigits="2" maxFractionDigits="2"/></c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="summary-row"><span>Tax</span><span>₹<fmt:formatNumber value="${tax}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span></div>
      <div class="summary-total-row"><span>Total</span><span>₹<fmt:formatNumber value="${finalTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></span></div>

      <div class="secure-note"><i class="fas fa-shield-alt"></i> Your payment information is secure and encrypted</div>
    </section>
  </div>
</div>

<script>
  // Card number formatting
  document.getElementById('cardNumber').addEventListener('input', function(e) {
    let val = e.target.value.replace(/\D/g, '').substring(0,16);
    e.target.value = val.match(/.{1,4}/g)?.join(' ') || val;
  });

  // Expiry date formatting
  document.getElementById('expiryDate').addEventListener('input', function(e) {
    let val = e.target.value.replace(/\D/g, '').substring(0,4);
    if(val.length > 2) {
      e.target.value = val.substring(0,2) + '/' + val.substring(2);
    } else {
      e.target.value = val;
    }
  });

  // CVV input restriction
  document.getElementById('cvv').addEventListener('input', function(e) {
    e.target.value = e.target.value.replace(/\D/g, '').substring(0,3);
  });

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