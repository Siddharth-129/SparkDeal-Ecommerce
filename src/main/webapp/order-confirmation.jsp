<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Order Confirmation - SparkDeal</title>
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
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem 1rem;
  }

  .confirmation-wrapper {
    background: var(--card);
    max-width: 620px;
    width: 100%;
    border-radius: 24px;
    box-shadow: var(--shadow);
    padding: 3.5rem 3rem 3rem;
    text-align: center;
    border: 1px solid rgba(99, 102, 241, 0.1);
    position: relative;
    overflow: hidden;
  }

  .confirmation-wrapper::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 6px;
    background: var(--gradient);
  }

  .success-icon {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    margin: 0 auto 2.5rem;
    background: var(--gradient);
    display: flex;
    align-items: center;
    justify-content: center;
    animation: scaleIn 0.6s cubic-bezier(.4, 0, .2, 1) forwards;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
    position: relative;
  }

  .success-icon::after {
    content: '';
    position: absolute;
    top: -10px;
    left: -10px;
    right: -10px;
    bottom: -10px;
    border-radius: 50%;
    background: var(--gradient);
    opacity: 0.2;
    animation: pulse 2s infinite;
  }

  .success-icon i {
    font-size: 3.5rem;
    color: white;
    position: relative;
    z-index: 2;
  }

  @keyframes scaleIn {
    from {
      transform: scale(0);
      opacity: 0;
    }
    to {
      transform: scale(1);
      opacity: 1;
    }
  }

  @keyframes pulse {
    0%, 100% {
      transform: scale(1);
      opacity: 0.2;
    }
    50% {
      transform: scale(1.1);
      opacity: 0.1;
    }
  }

  .confirmation-title {
    font-size: 2.8rem;
    font-weight: 800;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 1.3rem;
  }

  .confirmation-message {
    font-size: 1.2rem;
    color: var(--light);
    margin-bottom: 2.5rem;
    font-weight: 500;
    line-height: 1.7;
  }

  .order-details {
    background: var(--bg);
    padding: 2.5rem 2.5rem 3rem;
    border-radius: 20px;
    color: var(--dark);
    text-align: left;
    border: 1px solid rgba(99, 102, 241, 0.1);
    margin-bottom: 2rem;
    transition: all 0.3s ease;
  }

  .order-details:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
  }

  .order-detail-row {
    display: flex;
    justify-content: space-between;
    padding: 1.1rem 0;
    border-bottom: 1px solid rgba(99, 102, 241, 0.1);
    font-weight: 600;
    font-size: 1.1rem;
    transition: all 0.3s ease;
  }

  .order-detail-row:hover {
    background: rgba(99, 102, 241, 0.02);
    padding-left: 1rem;
    padding-right: 1rem;
    margin: 0 -1rem;
    border-radius: 8px;
  }

  .order-detail-row:last-child {
    font-weight: 800;
    font-size: 1.3rem;
    border-bottom: none;
    color: var(--primary);
    background: rgba(99, 102, 241, 0.05);
    padding: 1.5rem 1rem;
    margin: 1rem -1rem -1rem;
    border-radius: 12px;
  }

  .order-tracking {
    background: rgba(16, 185, 129, 0.1);
    border: 2px solid #10b981;
    border-radius: 18px;
    padding: 1.8rem 2.2rem;
    margin: 2.5rem 0 1.2rem;
    color: #065f46;
    font-weight: 500;
    font-size: 1rem;
    text-align: left;
    transition: all 0.3s ease;
  }

  .order-tracking:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.2);
  }

  .tracking-title {
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0.8rem;
    margin-bottom: 0.7rem;
    font-size: 1.15rem;
    color: #065f46;
  }

  .action-buttons {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 3rem;
  }

  .btn {
    padding: 1.2rem 2.5rem;
    border-radius: 16px;
    font-weight: 700;
    font-size: 1.1rem;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.8rem;
    border: none;
    transition: all 0.3s ease;
    text-decoration: none;
    position: relative;
    overflow: hidden;
  }

  .btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: left 0.5s;
  }

  .btn:hover::before {
    left: 100%;
  }

  .btn-primary {
    background: var(--gradient);
    color: white;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
  }

  .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
  }

  .btn-outline {
    background: transparent;
    color: var(--primary);
    border: 2px solid var(--primary);
  }

  .btn-outline:hover {
    background: var(--primary);
    color: white;
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
  }

  .btn i {
    font-size: 1.3rem;
  }

  .footer-info {
    margin-top: 2.5rem;
    font-size: 0.95rem;
    color: var(--light);
    padding-top: 2rem;
    border-top: 1px solid rgba(99, 102, 241, 0.1);
  }

  .footer-info p {
    margin: 0.5rem 0;
  }

  .footer-info a {
    color: var(--primary);
    text-decoration: none;
    font-weight: 600;
    transition: color 0.3s ease;
  }

  .footer-info a:hover {
    color: var(--primary-dark);
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

  @media (max-width: 720px) {
    .confirmation-wrapper {
      padding: 2.5rem 2rem;
      max-width: 95vw;
    }
    .order-details {
      padding: 2rem 2rem 2.5rem;
    }
    .action-buttons {
      flex-direction: column;
      gap: 1rem;
    }
    .btn {
      width: 100%;
      justify-content: center;
    }
    .confirmation-title {
      font-size: 2.3rem;
    }
  }
</style>
</head>
<body>
<div class="confirmation-wrapper fade-in">
  <div class="success-icon">
    <i class="fas fa-check"></i>
  </div>

  <h1 class="confirmation-title">Order Confirmed!</h1>
  <p class="confirmation-message">
    Thank you for your purchase! Your order has been successfully placed and is now being processed.
  </p>

  <section class="order-details fade-in">
    <div class="order-detail-row">
      <span>Order Number:</span>
      <strong>${sessionScope.orderNumber}</strong>
    </div>
    <div class="order-detail-row">
      <span>Customer:</span>
      ${sessionScope.userName}
    </div>
    <div class="order-detail-row">
      <span>Items:</span>
      ${sessionScope.orderItems} item(s)
    </div>
    <div class="order-detail-row">
      <span>Total Amount:</span>
      ₹<fmt:formatNumber value="${sessionScope.orderTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
    </div>
  </section>

  <section class="order-tracking fade-in">
    <div class="tracking-title">
      <i class="fas fa-truck"></i>
      Order Tracking
    </div>
    <p>Your order will be shipped within 2-3 business days. You will receive a tracking email as soon as your order is dispatched.</p>
  </section>

  <div class="action-buttons fade-in">
    <a href="products" class="btn btn-primary">
      <i class="fas fa-shopping-bag"></i>
      Continue Shopping
    </a>
    <a href="dashboard" class="btn btn-outline">
      <i class="fas fa-user"></i>
      My Account
    </a>
  </div>

  <section class="footer-info fade-in">
    <p>A confirmation email has been sent to your registered email address.</p>
    <p>Need help? <a href="#">Contact our support team</a></p>
  </section>
</div>

<script>
  // Add staggered animations
  document.addEventListener('DOMContentLoaded', () => {
    const fadeElements = document.querySelectorAll('.fade-in');
    fadeElements.forEach((el, index) => {
      el.style.animationDelay = `${index * 0.2}s`;
    });
  });

  <%
    // Clear order data from session after rendering
    session.removeAttribute("orderNumber");
    session.removeAttribute("orderTotal");
    session.removeAttribute("orderItems");
  %>
</script>
</body>
</html>