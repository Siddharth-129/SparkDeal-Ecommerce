<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>${categoryName} - SparkDeal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #fffbea; /* warm soft yellow background */
            color: #5a4d31;
            margin: 0;
            padding-top: 80px;
            min-height: 100vh;
            user-select: none;
        }
        nav.navbar {
            background: linear-gradient(135deg, #b5993a 0%, #d4be51 100%);
            box-shadow: 0 6px 24px rgba(181, 162, 69, 0.5);
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1100;
            padding: 0.9rem 1rem;
            font-weight: 700;
        }
        nav.navbar .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        nav.navbar .navbar-brand {
            font-size: 1.75rem;
            color: #fffbea !important;
            letter-spacing: 0.05em;
            user-select: none;
        }
        nav.navbar .nav-link {
            color: #fffbea !important;
            padding: 8px 12px;
            border-radius: 14px;
            font-size: 1.05rem;
            transition: background-color 0.3s ease;
            white-space: nowrap;
        }
        nav.navbar .nav-link:hover,
        nav.navbar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.28) !important;
            color: #f0e8b7 !important;
            text-decoration: none;
        }
        nav.navbar .btn-danger {
            background-color: #9e8830;
            border: none;
            user-select: none;
            transition: background-color 0.3s ease;
            font-weight: 700;
        }
        nav.navbar .btn-danger:hover {
            background-color: #b5993a;
            box-shadow: 0 0 15px rgba(181, 162, 69, 0.7);
        }

        .category-header {
            background: #fff9d3;
            margin: 0 auto 2rem;
            padding: 60px 20px 40px;
            text-align: center;
            border-radius: 24px;
            max-width: 900px;
            box-shadow: 0 12px 30px rgba(181, 162, 69, 0.2);
            user-select: none;
        }
        .category-header h2 {
            font-weight: 800;
            font-size: 3rem;
            color: #9e8830;
            margin-bottom: 0.4rem;
        }
        .category-header p {
            font-size: 1.25rem;
            color: #827c44;
            font-weight: 600;
            opacity: 0.85;
            max-width: 580px;
            margin: 0 auto;
        }

        .container.my-5 {
            max-width: 1140px !important;
            margin-bottom: 4rem !important;
        }

        .row {
            gap: 1.8rem;
            /* Using flex gap adjustment for Bootstrap row */
            display: flex;
            flex-wrap: wrap;
            justify-content: start;
        }
        .col-md-3 {
            flex: 0 0 calc(25% - 1.8rem);
            max-width: calc(25% - 1.8rem);
            display: flex;
        }

        .product-card {
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(181, 162, 69, 0.18);
            transition: box-shadow 0.3s ease, transform 0.3s ease;
            width: 100%;
            display: flex;
            flex-direction: column;
            background: #fffbea;
            cursor: pointer;
            user-select: none;
        }
        .product-card:hover {
            box-shadow: 0 20px 48px rgba(181, 162, 69, 0.38);
            transform: translateY(-8px);
        }
        .product-card img {
            border-radius: 20px 20px 0 0;
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .product-card:hover img {
            transform: scale(1.05);
        }
        .card-body {
            padding: 20px 18px 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            color: #5a4d31;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .product-price {
            font-size: 1.15rem;
            font-weight: 700;
            color: #9e8830;
            user-select: text;
        }
        .product-price del {
            color: #a69e67;
            margin-left: 8px;
            font-weight: 400;
        }
        .badge.bg-success {
            background-color: #b5993a !important;
            color: #fffbea;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 0.3em 0.7em;
            border-radius: 14px;
            margin-left: 10px;
            user-select: none;
        }
        .btn-primary {
            background: #b5993a;
            border: none;
            font-weight: 700;
            border-radius: 14px;
            padding: 10px 0;
            font-size: 1rem;
            color: #fffbea;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            width: 100%;
            user-select: none;
        }
        .btn-primary:hover, .btn-primary:focus {
            background: #9e8830;
            box-shadow: 0 8px 24px rgba(181, 162, 69, 0.5);
            text-decoration: none;
            color: #fffbea;
        }

        footer.footer {
            background: #b5993a;
            color: #fffbea;
            text-align: center;
            padding: 20px 15px;
            font-weight: 600;
            font-size: 1rem;
            user-select: none;
            margin-top: 60px;
            box-shadow: inset 0 3px 8px #9e883034;
        }

        /* Responsive tweaks */
        @media(max-width: 1024px) {
            .col-md-3 {
                flex: 0 0 calc(50% - 1.8rem);
                max-width: calc(50% - 1.8rem);
            }
            .category-header {
                font-size: 1rem;
                padding: 30px 15px 20px;
            }
            .category-header h2 {
                font-size: 2rem;
            }
        }
        @media(max-width: 600px) {
            .col-md-3 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg" role="navigation" aria-label="Primary Navigation">
    <div class="container">
        <a class="navbar-brand" href="dashboard" tabindex="0" aria-label="Go to Dashboard">Spark-Deal</a>
        <div class="ms-auto">
            <a href="dashboard" class="nav-link d-inline-block" tabindex="0">Home</a>
            <a href="products" class="nav-link d-inline-block active" aria-current="page" tabindex="0">Products</a>
            <a href="cart.jsp" class="nav-link d-inline-block" tabindex="0">Cart</a>
            <a href="orders.jsp" class="nav-link d-inline-block" tabindex="0">Orders</a>
            <a href="profile.jsp" class="nav-link d-inline-block" tabindex="0">Profile</a>
            <a href="logout" class="nav-link btn btn-danger btn-sm d-inline-block" tabindex="0" role="button">Logout</a>
        </div>
    </div>
</nav>

<section class="category-header" role="banner" aria-label="Category overview">
    <h2 tabindex="0">${categoryName}</h2>
    <p tabindex="0">Explore our wide collection of ${categoryName} products</p>
</section>

<main class="container" role="main">
    <div class="row">
        <c:forEach var="p" items="${products}">
            <article class="col-md-3 mb-4" tabindex="0" aria-label="${p.name} product card">
                <div class="card product-card h-100">
                    <img src="${p.imageUrl}" class="card-img-top" alt="${p.name} image" />
                    <div class="card-body">
                        <h6 class="card-title">${p.name}</h6>
                        <p class="product-price">
                            ₹${p.price - (p.price * p.discount / 100)}
                            <del>₹${p.price}</del>
                            <span class="badge bg-success">${p.discount}% OFF</span>
                        </p>
                        <a href="cart?add=${p.id}" class="btn btn-primary btn-sm w-100" role="button" aria-label="Add ${p.name} to cart">Add to Cart</a>
                    </div>
                </div>
            </article>
        </c:forEach>
    </div>
</main>

<footer class="footer" role="contentinfo">
    <p>&copy; <%= java.time.Year.now() %> ECommerceApp. All rights reserved.</p>
</footer>

</body>
</html>
