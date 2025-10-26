<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Dashboard - SparkDeal</title>
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
    margin: 0; padding: 0; box-sizing: border-box;
  }

  body {
    font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
    background: linear-gradient(135deg, #f8f9ff 0%, #f0f4ff 100%);
    color: var(--dark);
    line-height: 1.6;
    min-height: 100vh;
    transition: background-color 0.4s ease;
  }

  /* Sidebar */
  .header {
    height: 100vh;
    width: 260px;
    position: fixed;
    top: 0; left: 0;
    background: linear-gradient(180deg, var(--card) 0%, #fdfdff 100%);
    border-right: 1px solid rgba(99, 102, 241, 0.1);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: 4px 0 25px rgba(99, 102, 241, 0.08);
    padding: 2.5rem 1.5rem;
    z-index: 1000;
  }

  .logo {
    font-size: 2rem;
    font-weight: 800;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-align: center;
    margin-bottom: 3rem;
    letter-spacing: -0.01em;
  }

  .logo i {
    margin-right: 10px;
  }

  .nav-links {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .nav-links a {
    text-decoration: none;
    font-weight: 600;
    color: var(--light);
    font-size: 1.05rem;
    padding: 12px 16px;
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    display: flex;
    align-items: center;
    gap: 12px;
    position: relative;
    overflow: hidden;
  }

  .nav-links a::before {
    content: '';
    position: absolute;
    left: -100%;
    top: 0;
    width: 100%;
    height: 100%;
    background: var(--gradient);
    transition: left 0.3s ease;
    z-index: -1;
  }

  .nav-links a:hover,
  .nav-links a.active {
    color: white;
    transform: translateX(5px);
    box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
  }

  .nav-links a:hover::before,
  .nav-links a.active::before {
    left: 0;
  }

  .nav-links a .fas {
    font-size: 1.2rem;
    transition: transform 0.3s ease;
  }

  .nav-links a:hover .fas,
  .nav-links a.active .fas {
    transform: scale(1.1);
  }

  .user-info {
    padding: 1.5rem 0 0;
    border-top: 1px solid rgba(99, 102, 241, 0.1);
    display: flex;
    align-items: center;
    gap: 1rem;
    color: var(--dark);
    font-weight: 600;
  }

  .user-avatar {
    width: 50px; height: 50px;
    background: var(--gradient);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
    color: white;
    box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
    transition: transform 0.3s ease;
  }

  .user-avatar:hover {
    transform: scale(1.05);
  }

  /* Main Container */
  .container {
    margin-left: 280px;
    padding: 2.5rem 3rem 3rem;
    max-width: 1200px;
  }

  /* Welcome Section */
  .welcome-section {
    background: var(--gradient);
    padding: 3rem 2.5rem;
    border-radius: 20px;
    color: white;
    box-shadow: var(--shadow);
    margin-bottom: 3rem;
    position: relative;
    overflow: hidden;
  }

  .welcome-section::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 300px;
    height: 300px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
  }

  .welcome-title {
    font-size: 2.8rem;
    font-weight: 800;
    margin-bottom: 0.5rem;
    position: relative;
  }

  .welcome-subtitle {
    font-size: 1.2rem;
    font-weight: 500;
    opacity: 0.9;
    position: relative;
  }

  /* Stats Cards */
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
  }

  .stat-card {
    background: var(--card);
    border-radius: 16px;
    box-shadow: var(--shadow);
    padding: 2rem 1.5rem;
    display: flex;
    align-items: center;
    gap: 1.5rem;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: default;
    border: 1px solid rgba(99, 102, 241, 0.1);
    position: relative;
    overflow: hidden;
  }

  .stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 6px;
    height: 100%;
    background: var(--gradient);
  }

  .stat-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  }

  .stat-icon {
    font-size: 2.8rem;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transition: transform 0.3s ease;
  }

  .stat-card:hover .stat-icon {
    transform: scale(1.1);
  }

  .stat-number {
    font-size: 2.2rem;
    font-weight: 800;
    color: var(--dark);
    margin-bottom: 0.2rem;
  }

  .stat-label {
    font-size: 1rem;
    color: var(--light);
    font-weight: 600;
  }

  /* Section Header */
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2.5rem;
    padding-bottom: 1rem;
    border-bottom: 2px solid rgba(99, 102, 241, 0.1);
  }

  .section-title {
    font-size: 2.2rem;
    font-weight: 800;
    background: var(--gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }

  .view-all-btn {
    text-decoration: none;
    font-weight: 600;
    padding: 12px 28px;
    border-radius: 12px;
    background: transparent;
    border: 2px solid var(--primary);
    color: var(--primary);
    transition: all 0.3s ease;
    font-size: 1rem;
  }

  .view-all-btn:hover {
    background: var(--gradient);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(99, 102, 241, 0.3);
  }

  /* Quick Actions */
  .quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.8rem;
    margin-bottom: 3rem;
  }

  .action-card {
    background: var(--card);
    border: 2px solid transparent;
    text-align: center;
    padding: 2.5rem 1rem;
    color: var(--dark);
    text-decoration: none;
    border-radius: 16px;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    font-weight: 600;
    cursor: pointer;
    box-shadow: var(--shadow);
    position: relative;
    overflow: hidden;
  }

  .action-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: var(--gradient);
    transition: left 0.4s ease;
    z-index: 1;
  }

  .action-card:hover::before {
    left: 0;
  }

  .action-card:hover {
    color: white;
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(99, 102, 241, 0.3);
  }

  .action-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
    position: relative;
    z-index: 2;
    transition: all 0.3s ease;
  }

  .action-card:hover .action-icon {
    transform: scale(1.2);
  }

  .action-card span {
    position: relative;
    z-index: 2;
  }

  /* Categories */
  .categories-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.8rem;
    margin-bottom: 3rem;
  }

  .category-card {
    background: var(--card);
    padding: 2rem 1.5rem;
    border-radius: 16px;
    box-shadow: var(--shadow);
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid rgba(99, 102, 241, 0.1);
    position: relative;
    overflow: hidden;
  }

  .category-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 5px;
    height: 100%;
    background: var(--gradient);
    transition: width 0.3s ease;
  }

  .category-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  }

  .category-card:hover::before {
    width: 8px;
  }

  .category-name {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--dark);
    margin-bottom: 0.5rem;
  }

  .category-description {
    font-size: 0.95rem;
    color: var(--light);
    line-height: 1.5;
  }

  /* Product Grid */
  .products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
  }

  .product-card {
    background: var(--card);
    border-radius: 16px;
    box-shadow: var(--shadow);
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid rgba(99, 102, 241, 0.1);
  }

  .product-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
  }

  .product-image {
    width: 100%;
    height: 220px;
    object-fit: cover;
    transition: transform 0.5s ease;
  }

  .product-card:hover .product-image {
    transform: scale(1.1);
  }

  .product-info {
    padding: 1.8rem;
  }

  .product-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--dark);
    margin-bottom: 0.8rem;
    line-height: 1.4;
  }

  .product-description {
    font-size: 0.95rem;
    color: var(--light);
    margin-bottom: 1.2rem;
    line-height: 1.5;
  }

  .product-price {
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--primary);
    margin-bottom: 1.5rem;
  }

  .add-to-cart-btn {
    width: 100%;
    padding: 14px 0;
    background: var(--gradient);
    color: white;
    border: none;
    font-weight: 600;
    cursor: pointer;
    border-radius: 12px;
    transition: all 0.3s ease;
    font-size: 1rem;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
  }

  .add-to-cart-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
  }

  /* Empty State */
  .empty-state {
    text-align: center;
    padding: 4rem 2rem;
    color: var(--light);
    background: var(--card);
    border-radius: 16px;
    box-shadow: var(--shadow);
    margin: 2rem 0;
  }

  /* Responsive */
  @media (max-width: 1024px) {
    .header {
      width: 100%;
      height: 80px;
      flex-direction: row;
      bottom: 0;
      top: auto;
      border-top: 1px solid rgba(99, 102, 241, 0.1);
      border-right: none;
      padding: 0 2rem;
      z-index: 1000;
    }
    .nav-links {
      flex-direction: row;
      justify-content: space-around;
      width: 100%;
      gap: 0.5rem;
    }
    .nav-links a {
      padding: 10px 12px;
      font-size: 0.9rem;
    }
    .logo, .user-info {
      display: none;
    }
    .container {
      margin-left: 0;
      padding: 2rem 1.5rem 5rem;
    }
    .stats-grid {
      grid-template-columns: repeat(2, 1fr);
    }
    .quick-actions {
      grid-template-columns: repeat(2, 1fr);
    }
  }

  @media (max-width: 640px) {
    .stats-grid,
    .quick-actions {
      grid-template-columns: 1fr;
    }
    .products-grid {
      grid-template-columns: 1fr;
    }
    .welcome-title {
      font-size: 2.2rem;
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

<header class="header">
  <div class="logo"><i class="fas fa-bolt"></i>SparkDeal</div>
  <nav>
    <ul class="nav-links">
      <li><a href="home"><i class="fas fa-home"></i>Home</a></li>
      <li><a href="products"><i class="fas fa-shopping-bag"></i>Products</a></li>
      <li><a href="cart"><i class="fas fa-shopping-cart"></i>Cart</a></li>
      <li><a href="dashboard" class="active"><i class="fas fa-chart-line"></i>Dashboard</a></li>
      <li><a href="login" style="color: var(--primary);">Logout</a></li>
    </ul>
  </nav>
  <div class="user-info">
    <div class="user-avatar"><i class="fas fa-user"></i></div>
    <span>Hello, ${user}!</span>
  </div>
</header>

<div class="container">
  <div class="welcome-section fade-in">
    <h1 class="welcome-title">Welcome back, ${user}!</h1>
    <p class="welcome-subtitle">Here's your personalized dashboard overview</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card fade-in">
      <div class="stat-icon"><i class="fas fa-box"></i></div>
      <div>
        <div class="stat-number">${totalProducts}</div>
        <div class="stat-label">Total Products</div>
      </div>
    </div>
    <div class="stat-card fade-in">
      <div class="stat-icon"><i class="fas fa-tags"></i></div>
      <div>
        <div class="stat-number">${totalCategories}</div>
        <div class="stat-label">Product Categories</div>
      </div>
    </div>
    <div class="stat-card fade-in">
      <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
      <div>
        <div class="stat-number">1</div>
        <div class="stat-label">Active Users</div>
      </div>
    </div>
    <div class="stat-card fade-in">
      <div class="stat-icon"><i class="fas fa-shopping-bag"></i></div>
      <div>
        <div class="stat-number">0</div>
        <div class="stat-label">Orders Today</div>
      </div>
    </div>
  </div>

  <div class="section-header fade-in">
    <h2 class="section-title">Quick Shortcuts</h2>
  </div>
  <div class="quick-actions">
    <a href="products" class="action-card fade-in">
      <i class="fas fa-list action-icon"></i>
      <span>Browse Products</span>
    </a>
    <a href="cart" class="action-card fade-in">
      <i class="fas fa-shopping-cart action-icon"></i>
      <span>Check Cart</span>
    </a>
    <a href="#" class="action-card fade-in" onclick="alert('Coming soon!')">
      <i class="fas fa-plus action-icon"></i>
      <span>Add Product</span>
    </a>
    <a href="#" class="action-card fade-in" onclick="alert('Analytics coming soon!')">
      <i class="fas fa-chart-pie action-icon"></i>
      <span>Analytics</span>
    </a>
  </div>

  <c:if test="${not empty categories}">
    <div class="section-header fade-in">
      <h2 class="section-title">Categories</h2>
      <a href="products" class="view-all-btn">Explore All</a>
    </div>
    <div class="categories-grid">
      <c:forEach var="category" items="${categories}">
        <div class="category-card fade-in" onclick="filterByCategory('${category.name}')">
          <div class="category-name">${category.name}</div>
          <div class="category-description">
            <c:choose>
              <c:when test="${not empty category.description}">
                ${category.description}
              </c:when>
              <c:otherwise>Explore amazing ${category.name} deals</c:otherwise>
            </c:choose>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>

  <div class="section-header fade-in">
    <h2 class="section-title">Latest Products</h2>
    <a href="products" class="view-all-btn">View All</a>
  </div>

  <c:choose>
    <c:when test="${empty recentProducts}">
      <div class="empty-state fade-in">
        <p>No products yet — check back soon!</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="products-grid">
        <c:forEach var="product" items="${recentProducts}">
          <div class="product-card fade-in">
            <img src="${product.imageUrl}" alt="${product.name}" class="product-image" onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'">
            <div class="product-info">
              <div class="product-title">${product.name}</div>
              <div class="product-description">${product.description}</div>
              <div class="product-price">₹<fmt:formatNumber value="${product.price}" type="number" /></div>
              <form action="cart" method="post">
                <input type="hidden" name="action" value="add" />
                <input type="hidden" name="productId" value="${product.id}" />
                <button class="add-to-cart-btn" type="submit">Add to Cart</button>
              </form>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
  function filterByCategory(categoryName) {
    window.location.href = 'products?category=' + encodeURIComponent(categoryName);
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