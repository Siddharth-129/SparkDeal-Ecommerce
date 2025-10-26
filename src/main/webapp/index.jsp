<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>SparkDeal - Premium Shopping</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<style>
  /* Modern Reset */
  *, *::before, *::after {
    margin: 0; padding: 0; box-sizing: border-box;
  }
  body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
    color: #2d3748;
    line-height: 1.7;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    min-height: 100vh;
    overflow-x: hidden;
  }
  a {
    text-decoration: none;
    color: inherit;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  a:focus {
    outline: 3px solid rgba(99, 102, 241, 0.3);
    outline-offset: 3px;
  }

  /* Glassmorphism Header */
  .header {
    position: fixed;
    top: 0;
    width: 100%;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(20px) saturate(180%);
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    z-index: 1000;
    padding: 0 2rem;
    height: 80px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .header.scrolled {
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 8px 32px rgba(31, 38, 135, 0.1);
    height: 70px;
  }
  .nav-wrapper {
    max-width: 1400px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  /* Modern Logo */
  .logo {
    font-size: 2.1rem;
    font-weight: 800;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    display: flex;
    align-items: center;
    gap: 10px;
    user-select: none;
  }
  .logo:hover {
    transform: scale(1.02);
  }
  .logo i {
    font-size: 2.3rem;
  }

  /* Enhanced Search */
  .search-container {
    flex: 1 1 520px;
    max-width: 520px;
    margin: 0 2rem;
    position: relative;
  }
  @media (max-width: 968px) {
    .search-container {
      display: none;
    }
  }
  .search-input {
    width: 100%;
    padding: 16px 52px 16px 24px;
    border-radius: 16px;
    border: 2px solid transparent;
    background: rgba(255, 255, 255, 0.9);
    font-size: 16px;
    font-weight: 500;
    color: #2d3748;
    outline: none;
    box-shadow: 0 4px 20px rgba(99, 102, 241, 0.1);
    transition: all 0.3s ease;
  }
  .search-input::placeholder {
    color: #9ca3af;
  }
  .search-input:focus {
    border-color: #6366f1;
    box-shadow: 0 8px 30px rgba(99, 102, 241, 0.2);
    transform: translateY(-2px);
  }
  .search-btn {
    position: absolute;
    top: 50%;
    right: 8px;
    transform: translateY(-50%);
    width: 44px;
    height: 44px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: white;
    font-size: 18px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }
  .search-btn:hover {
    transform: translateY(-50%) scale(1.1);
    box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
  }

  /* Navigation */
  .nav-links {
    display: flex;
    align-items: center;
    gap: 2rem;
  }
  .nav-link {
    font-weight: 600;
    font-size: 15px;
    color: #4b5563;
    padding: 10px 18px;
    border-radius: 12px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
  }
  .nav-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    transition: left 0.3s ease;
    z-index: -1;
  }
  .nav-link:hover, .nav-link:focus {
    color: white;
    transform: translateY(-2px);
  }
  .nav-link:hover::before, .nav-link:focus::before {
    left: 0;
  }

  /* Cart with Animation */
  .cart-icon {
    position: relative;
    font-size: 24px;
    color: #4b5563;
    cursor: pointer;
    padding: 10px;
    border-radius: 12px;
    transition: all 0.3s ease;
  }
  .cart-icon:hover {
    color: #6366f1;
    transform: scale(1.1);
  }
  .cart-count {
    position: absolute;
    top: -5px;
    right: -5px;
    background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
    color: white;
    font-size: 11px;
    font-weight: 700;
    padding: 4px 8px;
    min-width: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
    animation: pulse 2s infinite;
  }
  @keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
  }

  /* User Menu */
  .user-menu {
    display: flex;
    align-items: center;
    gap: 1.5rem;
  }
  .user-menu .nav-link {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
  }
  .btn {
    padding: 12px 28px;
    border-radius: 14px;
    font-weight: 600;
    font-size: 15px;
    cursor: pointer;
    border: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: white;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
  }
  .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
  }
  .btn-outline {
    background: transparent;
    color: #6366f1;
    border: 2px solid #6366f1;
  }
  .btn-outline:hover {
    background: #6366f1;
    color: white;
    transform: translateY(-2px);
  }

  /* Hero Section with Gradient */
  .hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 140px 2rem 80px;
    text-align: center;
    color: white;
    position: relative;
    margin: 100px 2rem 4rem;
    border-radius: 28px;
    box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
    overflow: hidden;
  }
  .hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><polygon fill="rgba(255,255,255,0.05)" points="0,1000 1000,0 1000,1000"/></svg>');
    background-size: cover;
  }
  .hero-content h1 {
    font-size: 3.5rem;
    font-weight: 800;
    margin-bottom: 1.5rem;
    text-shadow: 0 4px 20px rgba(0,0,0,0.1);
  }
  .hero-content p {
    font-size: 1.3rem;
    opacity: 0.9;
    margin-bottom: 3rem;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
  }
  .hero-buttons {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    flex-wrap: wrap;
  }
  .btn-hero {
    padding: 18px 42px;
    border-radius: 16px;
    font-size: 17px;
    font-weight: 600;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .btn-white {
    background: rgba(255, 255, 255, 0.95);
    color: #6366f1;
    backdrop-filter: blur(10px);
  }
  .btn-white:hover {
    background: white;
    transform: translateY(-4px) scale(1.05);
    box-shadow: 0 20px 40px rgba(255, 255, 255, 0.2);
  }
  .btn-outline.btn-hero {
    background: transparent;
    border: 2px solid rgba(255, 255, 255, 0.8);
    color: white;
  }
  .btn-outline.btn-hero:hover {
    background: white;
    color: #6366f1;
    transform: translateY(-4px);
  }

  /* Features Grid */
  .features {
    background: white;
    padding: 6rem 2rem;
    border-radius: 28px;
    max-width: 1200px;
    margin: 4rem auto;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
  }
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
  }
  .section-title {
    text-align: center;
    margin-bottom: 4rem;
  }
  .section-title h2 {
    font-size: 2.8rem;
    font-weight: 800;
    background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 1rem;
  }
  .section-title p {
    font-size: 1.2rem;
    color: #6b7280;
    max-width: 600px;
    margin: 0 auto;
  }
  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2.5rem;
  }
  .feature-card {
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    border-radius: 24px;
    padding: 3rem 2rem;
    text-align: center;
    position: relative;
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
  .feature-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    transform: scaleX(0);
    transition: transform 0.3s ease;
  }
  .feature-card:hover {
    transform: translateY(-12px) scale(1.02);
    box-shadow: 0 30px 60px rgba(99, 102, 241, 0.15);
  }
  .feature-card:hover::before {
    transform: scaleX(1);
  }
  .feature-icon {
    width: 80px;
    height: 80px;
    margin: 0 auto 2rem;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: white;
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    transition: all 0.3s ease;
  }
  .feature-card:hover .feature-icon {
    transform: scale(1.1) rotate(5deg);
  }
  .feature-card h3 {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: #1f2937;
  }
  .feature-card p {
    color: #6b7280;
    line-height: 1.6;
  }

  /* Categories with Hover Effects */
  .categories {
    max-width: 1200px;
    margin: 0 auto 6rem;
    padding: 0 2rem;
  }
  .categories-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 2rem;
  }
  .category-card {
    background: white;
    border-radius: 20px;
    padding: 3rem 1.5rem;
    text-align: center;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
  }
  .category-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    opacity: 0;
    transition: opacity 0.3s ease;
    z-index: 1;
  }
  .category-card:hover {
    transform: translateY(-10px) scale(1.03);
    box-shadow: 0 30px 60px rgba(99, 102, 241, 0.2);
  }
  .category-card:hover::before {
    opacity: 0.05;
  }
  .category-card > * {
    position: relative;
    z-index: 2;
  }
  .category-icon {
    font-size: 3.5rem;
    margin-bottom: 1.5rem;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transition: all 0.3s ease;
  }
  .category-card:hover .category-icon {
    transform: scale(1.2);
  }
  .category-card h3 {
    font-size: 1.4rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
    color: #1f2937;
  }
  .category-card p {
    color: #6b7280;
    font-size: 0.95rem;
  }

  /* Modern CTA */
  .cta {
    background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
    color: white;
    text-align: center;
    padding: 6rem 2rem;
    border-radius: 28px;
    max-width: 800px;
    margin: 6rem auto;
    position: relative;
    overflow: hidden;
  }
  .cta::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, transparent 70%);
    animation: rotate 20s linear infinite;
  }
  @keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
  }
  .cta h2 {
    font-size: 3.2rem;
    font-weight: 800;
    margin-bottom: 1.5rem;
    position: relative;
  }
  .cta p {
    font-size: 1.3rem;
    margin-bottom: 3rem;
    opacity: 0.9;
    position: relative;
  }
  .btn-primary.btn-hero {
    padding: 20px 50px;
    font-size: 1.1rem;
    position: relative;
    z-index: 2;
  }

  /* Newsletter with Glass Effect */
  .newsletter {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    padding: 5rem 2rem;
    max-width: 700px;
    margin: 0 auto 6rem;
    border-radius: 28px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
  }
  .newsletter .section-title h2 {
    background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  .newsletter-form {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
    max-width: 500px;
    margin: 0 auto;
  }
  .newsletter-input {
    flex: 1 1 auto;
    min-width: 300px;
    padding: 16px 24px;
    border-radius: 14px;
    border: 2px solid #e5e7eb;
    background: white;
    font-size: 1rem;
    font-weight: 500;
    color: #2d3748;
    transition: all 0.3s ease;
  }
  .newsletter-input:focus {
    border-color: #6366f1;
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.15);
    transform: translateY(-2px);
  }

  /* Enhanced Footer */
  .footer {
    background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    color: #cbd5e1;
    padding: 6rem 2rem 3rem;
  }
  .footer-content {
    max-width: 1200px;
    margin: 0 auto 4rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 3rem;
  }
  .footer-section h3 {
    margin-bottom: 1.5rem;
    font-size: 1.4rem;
    font-weight: 700;
    color: #f8fafc;
  }
  .footer-section p {
    color: #94a3b8;
    line-height: 1.7;
  }
  .footer-section ul {
    list-style: none;
  }
  .footer-section ul li {
    margin-bottom: 0.8rem;
  }
  .footer-section ul li a {
    color: #94a3b8;
    transition: all 0.3s ease;
    display: inline-block;
  }
  .footer-section ul li a:hover {
    color: #6366f1;
    transform: translateX(5px);
  }
  .footer-bottom {
    border-top: 1px solid #334155;
    text-align: center;
    color: #94a3b8;
    font-size: 0.9rem;
    padding-top: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }
  .social-links {
    margin-top: 2rem;
    display: flex;
    gap: 1rem;
  }
  .social-link {
    width: 50px;
    height: 50px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    color: #cbd5e1;
    font-size: 1.2rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }
  .social-link:hover {
    background: #6366f1;
    color: white;
    transform: translateY(-5px) rotate(5deg);
    box-shadow: 0 10px 25px rgba(99, 102, 241, 0.3);
  }

  /* Responsive Design */
  @media (max-width: 968px) {
    .nav-wrapper {
      padding: 0 1rem;
    }
    .hero {
      margin: 100px 1rem 3rem;
      padding: 100px 1rem 60px;
    }
    .hero-content h1 {
      font-size: 2.8rem;
    }
    .features-grid, .categories-grid {
      grid-template-columns: 1fr;
      gap: 2rem;
    }
    .cta h2 {
      font-size: 2.5rem;
    }
  }

  /* Advanced Animations */
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(40px) scale(0.95);
    }
    to {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }
  .fade-in-up {
    opacity: 0;
    animation: fadeInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  }
  .stagger-animation > * {
    opacity: 0;
    animation: fadeInUp 0.6s cubic-bezier(0.4, 0, 0.2, 1) forwards;
  }
  .stagger-animation > *:nth-child(1) { animation-delay: 0.1s; }
  .stagger-animation > *:nth-child(2) { animation-delay: 0.2s; }
  .stagger-animation > *:nth-child(3) { animation-delay: 0.3s; }
  .stagger-animation > *:nth-child(4) { animation-delay: 0.4s; }
</style>
</head>
<body>
<header class="header" role="banner" aria-label="Site Header">
  <div class="nav-wrapper">
    <a href="home" class="logo" aria-label="Home">
      <i class="fas fa-bolt"></i> SparkDeal
    </a>
    <div class="search-container" role="search" aria-label="Product Search">
      <form action="products" method="get" novalidate>
        <input type="search" class="search-input" name="search" placeholder="Discover amazing products..." aria-label="Search products" />
        <button class="search-btn" aria-label="Search"><i class="fas fa-search"></i></button>
      </form>
    </div>
    <nav class="nav-links" role="navigation" aria-label="Main Menu">
      <a href="products" class="nav-link" tabindex="0">Explore</a>
      <a href="cart" class="nav-link cart-icon" aria-label="Shopping Cart" tabindex="0">
        <i class="fas fa-shopping-bag"></i>
        <span class="cart-count" aria-live="polite" aria-atomic="true">0</span>
      </a>
      <div class="user-menu">
        <%
          HttpSession sessionObj = request.getSession(false);
          if (sessionObj != null && sessionObj.getAttribute("userName") != null) {
        %>
        <a href="dashboard" class="nav-link" tabindex="0">
          <i class="fas fa-user-circle"></i> <%= sessionObj.getAttribute("userName") %>
        </a>
        <a href="logout" class="btn btn-outline" tabindex="0">Sign Out</a>
        <%
          } else {
        %>
        <a href="login.jsp" class="nav-link" tabindex="0">Sign In</a>
        <a href="signup.jsp" class="btn btn-primary" tabindex="0">Join Free</a>
        <%
          }
        %>
      </div>
    </nav>
  </div>
</header>

<section class="hero" aria-label="Main Banner">
  <div class="hero-content fade-in-up">
    <h1>Elevate Your Shopping Experience</h1>
    <p>Discover premium products with exclusive deals and lightning-fast delivery</p>
    <div class="hero-buttons">
      <a href="products" class="btn btn-white btn-hero" tabindex="0">
        <i class="fas fa-rocket"></i> Start Shopping
      </a>
      <a href="#categories" class="btn btn-outline btn-hero" tabindex="0">
        <i class="fas fa-gem"></i> Premium Collection
      </a>
    </div>
  </div>
</section>

<section class="features" aria-label="Features Section">
  <div class="container">
    <div class="section-title">
      <h2>Why Shop With Us</h2>
      <p>Experience the future of online shopping with our premium services</p>
    </div>
    <div class="features-grid stagger-animation">
      <div class="feature-card" tabindex="0" aria-label="Lightning Delivery Feature">
        <div class="feature-icon">
          <i class="fas fa-bolt"></i>
        </div>
        <h3>Lightning Fast</h3>
        <p>Same-day delivery on thousands of products in metropolitan areas</p>
      </div>
      <div class="feature-card" tabindex="0" aria-label="Premium Quality Feature">
        <div class="feature-icon">
          <i class="fas fa-crown"></i>
        </div>
        <h3>Premium Quality</h3>
        <p>Curated selection of high-quality products from trusted brands</p>
      </div>
      <div class="feature-card" tabindex="0" aria-label="Secure Shopping Feature">
        <div class="feature-icon">
          <i class="fas fa-shield-alt"></i>
        </div>
        <h3>Secure Shopping</h3>
        <p>Bank-level security with end-to-end encryption for all transactions</p>
      </div>
      <div class="feature-card" tabindex="0" aria-label="Expert Support Feature">
        <div class="feature-icon">
          <i class="fas fa-headset"></i>
        </div>
        <h3>Expert Support</h3>
        <p>24/7 customer service with dedicated shopping assistants</p>
      </div>
    </div>
  </div>
</section>

<section class="categories" id="categories" aria-label="Shop By Category">
  <div class="container">
    <div class="section-title">
      <h2>Premium Categories</h2>
      <p>Explore our carefully curated collections</p>
    </div>
    <div class="categories-grid stagger-animation">
      <a href="products?category=electronics" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-laptop-code"></i>
        </div>
        <h3>Tech & Gadgets</h3>
        <p>Cutting-edge technology</p>
      </a>
      <a href="products?category=clothing" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-tshirt"></i>
        </div>
        <h3>Fashion</h3>
        <p>Trendsetting styles</p>
      </a>
      <a href="products?category=home" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-couch"></i>
        </div>
        <h3>Home & Living</h3>
        <p>Designer home essentials</p>
      </a>
      <a href="products?category=sports" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-dumbbell"></i>
        </div>
        <h3>Fitness</h3>
        <p>Premium workout gear</p>
      </a>
      <a href="products?category=books" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-book-open"></i>
        </div>
        <h3>Books & Media</h3>
        <p>Knowledge & entertainment</p>
      </a>
      <a href="products?category=beauty" class="category-card" tabindex="0">
        <div class="category-icon">
          <i class="fas fa-spa"></i>
        </div>
        <h3>Beauty</h3>
        <p>Luxury skincare</p>
      </a>
    </div>
  </div>
</section>

<section class="cta" aria-label="Call To Action">
  <div class="container">
    <h2>Ready for Premium Shopping?</h2>
    <p>Join our exclusive community and discover a world of quality products</p>
    <a href="products" class="btn btn-primary btn-hero" tabindex="0">
      <i class="fas fa-star"></i> Explore Premium Collection
    </a>
  </div>
</section>

<section class="newsletter" aria-labelledby="newsletter-title">
  <div class="container">
    <div class="section-title">
      <h2 id="newsletter-title">Stay in the Loop</h2>
      <p>Get exclusive access to premium deals and new arrivals</p>
    </div>
    <form class="newsletter-form" onsubmit="alert('Welcome to our premium newsletter!'); return false;">
      <input type="email" name="email" class="newsletter-input" placeholder="Enter your email for exclusive deals" required aria-label="Email address"/>
      <button type="submit" class="btn btn-primary" aria-label="Subscribe to newsletter">Get Premium Access</button>
    </form>
  </div>
</section>

<footer class="footer" role="contentinfo">
  <div class="container">
    <div class="footer-content">
      <div class="footer-section">
        <h3>SparkDeal</h3>
        <p>Your premier destination for quality products and exceptional shopping experiences.</p>
        <div class="social-links">
          <a href="#" class="social-link" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
          <a href="#" class="social-link" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
          <a href="#" class="social-link" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="social-link" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
      <div class="footer-section">
        <h3>Shop</h3>
        <ul>
          <li><a href="products">All Collections</a></li>
          <li><a href="#categories">Premium Categories</a></li>
          <li><a href="#">New Arrivals</a></li>
          <li><a href="#">Best Sellers</a></li>
          <li><a href="#">Limited Edition</a></li>
        </ul>
      </div>
      <div class="footer-section">
        <h3>Support</h3>
        <ul>
          <li><a href="#">Contact Us</a></li>
          <li><a href="#">Shipping Info</a></li>
          <li><a href="#">Returns & Exchanges</a></li>
          <li><a href="#">FAQ</a></li>
          <li><a href="#">Size Guide</a></li>
        </ul>
      </div>
      <div class="footer-section">
        <h3>Account</h3>
        <ul>
          <li><a href="login.jsp">Sign In</a></li>
          <li><a href="signup.jsp">Create Account</a></li>
          <li><a href="dashboard">My Profile</a></li>
          <li><a href="cart">Shopping Bag</a></li>
          <li><a href="#">Wishlist</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">&copy; <%= java.time.Year.now() %> SparkDeal Premium. All rights reserved.</div>
  </div>
</footer>

<script>
  // Enhanced smooth scroll with offset
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', e => {
      e.preventDefault();
      const target = document.querySelector(anchor.getAttribute('href'));
      if(target) {
        const offset = 80;
        const targetPosition = target.getBoundingClientRect().top + window.pageYOffset - offset;
        window.scrollTo({ top: targetPosition, behavior: 'smooth' });
      }
    });
  });

  // Advanced header scroll effect
  const header = document.querySelector('.header');
  let lastScroll = 0;
  window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    if(currentScroll > 100) {
      header.classList.add('scrolled');
      if(currentScroll > lastScroll && currentScroll > 200) {
        header.style.transform = 'translateY(-100%)';
      } else {
        header.style.transform = 'translateY(0)';
      }
    } else {
      header.classList.remove('scrolled');
      header.style.transform = 'translateY(0)';
    }
    lastScroll = currentScroll;
  });

  // Staggered animation observer
  const observer = new IntersectionObserver((entries, obs) => {
    entries.forEach(entry => {
      if(entry.isIntersecting) {
        entry.target.classList.add('fade-in-up');
        if(entry.target.classList.contains('stagger-animation')) {
          Array.from(entry.target.children).forEach((child, index) => {
            child.style.animationDelay = `${0.1 + index * 0.1}s`;
          });
        }
        obs.unobserve(entry.target);
      }
    });
  }, { root: null, rootMargin: '0px', threshold: 0.1 });

  document.querySelectorAll('.features-grid, .categories-grid, .hero-content').forEach(el => observer.observe(el));

  // Cart count animation
  let cartCount = 0;
  const cartElement = document.querySelector('.cart-count');
  setInterval(() => {
    if(Math.random() > 0.7 && cartCount < 99) {
      cartCount++;
      cartElement.textContent = cartCount;
      cartElement.style.animation = 'none';
      setTimeout(() => cartElement.style.animation = 'pulse 2s infinite', 10);
    }
  }, 3000);
</script>
</body>
</html>