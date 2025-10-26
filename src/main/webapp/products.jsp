<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Collection - SparkDeal</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
<style>
    :root {
        --primary: #6366f1;
        --primary-dark: #4f46e5;
        --secondary: #f59e0b;
        --accent: #8b5cf6;
        --dark: #1f2937;
        --light: #6b7280;
        --bg: #f8fafc;
        --card: #ffffff;
        --shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
    }

    body {
        font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
        background: linear-gradient(135deg, #f8f9ff 0%, #f0f4ff 100%);
        color: var(--dark);
        line-height: 1.6;
        min-height: 100vh;
        overflow-x: hidden;
    }

    .header {
        position: fixed;
        top: 0;
        left: 0;
        width: 280px;
        height: 100vh;
        background: linear-gradient(180deg, var(--card) 0%, #fdfdff 100%);
        border-right: 1px solid rgba(99, 102, 241, 0.1);
        display: flex;
        flex-direction: column;
        padding: 2.5rem 0 2rem 0;
        box-shadow: 4px 0 25px rgba(99, 102, 241, 0.08);
        z-index: 1000;
        justify-content: space-between;
    }

    .sidebar-content {
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .logo {
        font-size: 2.2rem;
        font-weight: 800;
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-align: left;
        padding-left: 2.2rem;
        padding-bottom: 2.5rem;
        display: flex;
        align-items: center;
        letter-spacing: -0.01em;
    }

    .logo i {
        font-size: 2.3rem;
        margin-right: 12px;
    }

    .nav-links {
        list-style: none;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        padding-left: 0;
        flex: 1 0 auto;
    }

    .nav-links li {
        margin-bottom: 0.25rem;
    }

    .nav-links a {
        text-decoration: none;
        font-weight: 600;
        color: var(--light);
        font-size: 1.1rem;
        padding: 14px 1.8rem 14px 2.2rem;
        border-radius: 14px;
        display: flex;
        align-items: center;
        gap: 1.3rem;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        margin: 0 0.8rem;
    }

    .nav-links a .fas {
        font-size: 1.25rem;
        min-width: 28px;
        text-align: center;
        transition: all 0.3s ease;
    }

    .nav-links a.active,
    .nav-links a:hover {
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        color: white;
        transform: translateX(5px);
        box-shadow: 0 5px 15px rgba(99, 102, 241, 0.3);
    }

    .nav-links a.active .fas,
    .nav-links a:hover .fas {
        transform: scale(1.1);
    }

    .sidebar-bottom {
        padding: 0 2.2rem;
        width: 100%;
    }

    .user-info-block {
        display: flex;
        align-items: center;
        gap: 1.2rem;
        margin-top: 1rem;
        border-radius: 14px;
        background: var(--card);
        padding: 1rem 1.2rem;
        font-weight: 600;
        color: var(--dark);
        box-shadow: var(--shadow);
        margin-bottom: 1.2rem;
        transition: all 0.3s ease;
        border: 1px solid rgba(99, 102, 241, 0.1);
    }
    
    .user-info-block:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
    }

    .user-info-block .user-avatar {
        width: 46px;
        height: 46px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
    }

    .logout-btn {
        margin-top: 1rem;
        width: 100%;
        background: transparent;
        border: 2px solid #ef4444;
        color: #ef4444;
        font-weight: 600;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 0.8rem;
        cursor: pointer;
        transition: all 0.3s ease;
        padding: 12px 1.2rem;
        border-radius: 12px;
        justify-content: center;
    }
    
    .logout-btn:hover {
        background: #ef4444;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
    }

    .container {
        margin-left: 280px;
        padding: 2.5rem 3rem 3rem;
        max-width: 1400px;
    }

    .page-header {
        text-align: center;
        margin-bottom: 3rem;
    }
    
    .page-title {
        font-size: 2.8rem;
        font-weight: 800;
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 0.5rem;
        letter-spacing: -0.02em;
    }
    
    .page-subtitle {
        font-size: 1.2rem;
        color: var(--light);
        font-weight: 500;
    }

    .filter-bar {
        background: var(--card);
        padding: 1.5rem 1.8rem;
        border-radius: 16px;
        box-shadow: var(--shadow);
        margin-bottom: 2rem;
        display: flex;
        gap: 1.2rem;
        align-items: center;
        border: 1px solid rgba(99, 102, 241, 0.1);
    }

    .search-box {
        flex: 1;
        min-width: 260px;
        position: relative;
    }
    
    .search-input {
        width: 100%;
        padding: 14px 20px 14px 45px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 1rem;
        color: var(--dark);
        transition: all 0.3s ease;
        background: var(--bg);
    }
    
    .search-input:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        background: white;
    }
    
    .search-box::before {
        content: '\f002';
        font-family: 'Font Awesome 6 Free';
        font-weight: 900;
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--light);
        z-index: 2;
    }

    .filter-select {
        padding: 13px 16px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        background: var(--bg);
        cursor: pointer;
        font-size: 1rem;
        color: var(--dark);
        transition: all 0.3s ease;
        font-weight: 500;
    }
    
    .filter-select:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }

    .sort-by {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        color: var(--light);
        font-weight: 600;
    }
    
    .sort-by label {
        font-weight: 700;
        color: var(--primary);
        user-select: none;
    }

    .products-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
    }
    
    .products-count {
        color: var(--light);
        font-size: 1.05rem;
        font-weight: 600;
        background: var(--card);
        padding: 10px 18px;
        border-radius: 10px;
        box-shadow: var(--shadow);
    }
    
    .view-options {
        display: flex;
        gap: 0.6rem;
    }
    
    .view-btn {
        padding: 10px 16px;
        background: var(--card);
        border-radius: 10px;
        border: 2px solid #e5e7eb;
        cursor: pointer;
        color: var(--light);
        font-weight: 600;
        font-size: 1.1rem;
        transition: all 0.3s ease;
        box-shadow: var(--shadow);
    }
    
    .view-btn.active {
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        color: white;
        border-color: transparent;
        transform: scale(1.05);
    }
    
    .view-btn:hover:not(.active) {
        border-color: var(--primary);
        color: var(--primary);
        transform: translateY(-2px);
    }

    .products-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 1.8rem;
        margin-bottom: 3rem;
    }

    .product-card {
        background: var(--card);
        border-radius: 16px;
        box-shadow: var(--shadow);
        overflow: hidden;
        display: flex;
        flex-direction: column;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        height: 380px;
        position: relative;
        border: 1px solid rgba(99, 102, 241, 0.08);
    }
    
    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    }

    .product-image-container {
        height: 200px;
        position: relative;
        overflow: hidden;
    }
    
    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .product-card:hover .product-image {
        transform: scale(1.08);
    }

    .product-badge {
        position: absolute;
        top: 12px;
        left: 12px;
        background: linear-gradient(135deg, var(--secondary) 0%, #f97316 100%);
        color: white;
        padding: 6px 12px;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 700;
        user-select: none;
        box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        z-index: 2;
    }

    .wishlist-btn {
        position: absolute;
        top: 12px;
        right: 12px;
        width: 38px;
        height: 38px;
        background: var(--card);
        border: none;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        color: var(--light);
        font-size: 1.1rem;
        transition: all 0.3s ease;
        box-shadow: var(--shadow);
        z-index: 2;
    }
    
    .wishlist-btn:hover {
        background: var(--primary);
        color: white;
        transform: scale(1.1);
    }

    .product-info {
        padding: 1.5rem;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .product-title {
        font-size: 1.15rem;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 0.5rem;
        line-height: 1.4;
    }

    .product-description {
        font-size: 0.9rem;
        color: var(--light);
        margin-bottom: 1rem;
        flex-grow: 1;
        line-height: 1.5;
    }

    .product-price {
        font-size: 1.35rem;
        font-weight: 800;
        color: var(--primary);
        margin-bottom: 1.2rem;
    }

    .product-actions {
        display: flex;
        gap: 0.6rem;
    }

    .add-to-cart-btn {
        flex: 1;
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        color: white;
        border: none;
        padding: 12px 0;
        font-weight: 600;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 0.95rem;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
    }
    
    .add-to-cart-btn:hover, .add-to-cart-btn:focus {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
    }

    .quick-view-btn {
        background: var(--bg);
        color: var(--primary);
        border: 2px solid #e5e7eb;
        padding: 12px 0;
        width: 120px;
        border-radius: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-weight: 600;
        font-size: 0.95rem;
    }
    
    .quick-view-btn:hover, .quick-view-btn:focus {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
        transform: translateY(-2px);
    }

    .error-message, .success-message {
        padding: 1.2rem;
        border-radius: 12px;
        margin-bottom: 2rem;
        text-align: center;
        font-weight: 600;
        user-select: none;
        box-shadow: var(--shadow);
    }
    
    .error-message {
        background: #fef2f2;
        color: #dc2626;
        border-left: 4px solid #dc2626;
    }
    
    .success-message {
        background: #f0fdf4;
        color: #16a34a;
        border-left: 4px solid #16a34a;
    }

    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--light);
        background: var(--card);
        border-radius: 16px;
        box-shadow: var(--shadow);
        margin: 2rem 0;
    }
    
    .empty-icon {
        font-size: 4rem;
        margin-bottom: 1.5rem;
        background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .empty-title {
        font-size: 1.5rem;
        color: var(--dark);
        margin-bottom: 0.5rem;
        font-weight: 700;
    }
    
    .empty-message {
        color: var(--light);
        font-size: 1rem;
    }

    @media (max-width: 1024px) {
        .header {
            display: none;
        }
        
        .container {
            margin-left: 0;
            padding: 2rem 1.5rem;
        }
        
        .filter-bar {
            flex-direction: column;
            gap: 1rem;
        }
        
        .search-box {
            min-width: 100%;
        }
        
        .products-grid {
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1.5rem;
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
    <div class="sidebar-content">
        <div class="logo">
            <i class="fas fa-bolt"></i> SparkDeal
        </div>
        <nav>
            <ul class="nav-links">
                <li><a href="home"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="products" class="active"><i class="fas fa-shopping-bag"></i> Products</a></li>
                <li><a href="cart"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.userName}">
                        <li><a href="dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                        <li><a href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
    <div class="sidebar-bottom">
        <c:if test="${not empty sessionScope.userName}">
            <div class="user-info-block">
                <div class="user-avatar"><i class="fas fa-user"></i></div>
                <span>Hello, ${sessionScope.userName}</span>
            </div>
            <form action="logout" method="get">
                <button type="submit" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </c:if>
    </div>
</header>

<div class="container">
    <div class="page-header fade-in">
        <h1 class="page-title">Our Collection</h1>
        <p class="page-subtitle">Discover amazing products at unbeatable prices</p>
    </div>
    
    <c:if test="${not empty error}">
        <div class="error-message fade-in"><i class="fas fa-exclamation-triangle"></i> ${error}</div>
    </c:if>
    
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message fade-in"><i class="fas fa-check-circle"></i> ${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    
    <div class="filter-bar fade-in">
        <div class="search-box">
            <input type="text" class="search-input" placeholder="Search products..." id="searchInput" />
        </div>
        <select class="filter-select" id="priceFilter">
            <option value="">All Prices</option>
            <option value="0-50">Under ₹50</option>
            <option value="50-100">₹50 - ₹100</option>
            <option value="100-200">₹100 - ₹200</option>
            <option value="200+">Over ₹200</option>
        </select>
        <div class="sort-by">
            <label>Sort by:</label>
            <select class="filter-select" id="sortBy">
                <option value="name">Name</option>
                <option value="price-low">Price: Low to High</option>
                <option value="price-high">Price: High to Low</option>
                <option value="newest">Newest</option>
            </select>
        </div>
    </div>
    
    <div class="products-header fade-in">
        <div class="products-count">Showing ${totalProducts} products</div>
        <div class="view-options">
            <button class="view-btn active" data-view="grid"><i class="fas fa-th"></i></button>
            <button class="view-btn" data-view="list"><i class="fas fa-list"></i></button>
        </div>
    </div>
    
    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state fade-in">
                <div class="empty-icon"><i class="fas fa-box-open"></i></div>
                <h2 class="empty-title">No Products Found</h2>
                <p class="empty-message">We couldn't find any products. Please check back later!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="products-grid" id="productsGrid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card fade-in" data-price="${product.price}" data-name="${product.name}">
                        <div class="product-image-container">
                            <img src="${product.imageUrl}" alt="${product.name}" class="product-image" onerror="this.src='https://via.placeholder.com/400x300?text=No+Image'"/>
                            <c:if test="${product.price < 50}">
                                <div class="product-badge">Best Deal</div>
                            </c:if>
                            <button class="wishlist-btn" onclick="toggleWishlist(${product.id})">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                        <div class="product-info">
                            <h3 class="product-title">${product.name}</h3>
                            <p class="product-description">${product.description}</p>
                            <div class="product-price">₹<fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/></div>
                            <div class="product-actions">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.userName}">
                                        <form action="cart" method="post" style="flex: 1;">
                                            <input type="hidden" name="action" value="add" />
                                            <input type="hidden" name="productId" value="${product.id}" />
                                            <button type="submit" class="add-to-cart-btn"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="add-to-cart-btn" onclick="alert('Please login to add items to your cart!')">
                                            <i class="fas fa-shopping-cart"></i> Add to Cart
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                <button class="quick-view-btn" onclick="alert('Quick view feature coming soon!')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function toggleWishlist(productId) {
        const btn = event.target.closest('.wishlist-btn');
        const icon = btn.querySelector('i');
        if (icon.classList.contains('far')) {
            icon.classList.remove('far');
            icon.classList.add('fas');
            btn.style.background = 'var(--primary)';
            btn.style.color = 'white';
            alert('Added to wishlist!');
        } else {
            icon.classList.remove('fas');
            icon.classList.add('far');
            btn.style.background = 'var(--card)';
            btn.style.color = 'var(--light)';
            alert('Removed from wishlist!');
        }
    }

    document.getElementById('searchInput').addEventListener('input', function() {
        const value = this.value.toLowerCase();
        document.querySelectorAll('.product-card').forEach(product => {
            const name = product.dataset.name.toLowerCase();
            const desc = product.querySelector('.product-description').textContent.toLowerCase();
            product.style.display = (name.includes(value) || desc.includes(value)) ? 'flex' : 'none';
        });
    });

    document.querySelectorAll('.view-btn').forEach(button => {
        button.addEventListener('click', () => {
            document.querySelector('.view-btn.active').classList.remove('active');
            button.classList.add('active');
            document.getElementById('productsGrid').style.gridTemplateColumns =
                button.dataset.view === 'list' ? '1fr'
                                               : 'repeat(auto-fill, minmax(280px, 1fr))';
        });
    });

    // Add fade-in animation to elements
    document.addEventListener('DOMContentLoaded', () => {
        const fadeElements = document.querySelectorAll('.fade-in');
        fadeElements.forEach((el, index) => {
            el.style.animationDelay = `${index * 0.1}s`;
        });
    });
</script>
</body>
</html>