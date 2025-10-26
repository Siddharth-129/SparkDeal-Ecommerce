<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body */
        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Inter', sans-serif;
            margin: 0;
        }

        /* Card */
        .card {
            background: #ffffff;
            border-radius: 16px;
            padding: 2rem 1.8rem;
            width: 360px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }

        h3 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 1.8rem;
            font-size: 1.7rem;
            color: #111827;
        }

        /* Inputs */
        .form-control {
            border-radius: 12px;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            background: #f9fafb;
            color: #111827;
            font-weight: 500;
            transition: all 0.3s;
        }

        .form-control::placeholder {
            color: #9ca3af;
        }

        .form-control:focus {
            outline: none;
            border-color: #6366f1;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.2);
            color: #111827;
        }

        /* Button */
        .btn-primary {
            background: linear-gradient(135deg, #6ee7b7, #3b82f6);
            border: none;
            border-radius: 12px;
            padding: 0.75rem;
            font-weight: 600;
            color: #fff;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #3b82f6, #6ee7b7);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(59,130,246,0.3);
        }

        /* Links */
        a {
            color: #3b82f6;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #6366f1;
            text-decoration: underline;
        }

        p.text-center {
            margin-top: 1rem;
            font-size: 0.95rem;
            color: #555;
        }

        /* Responsive */
        @media (max-width: 500px) {
            .card {
                width: 90%;
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h3>Login</h3>
        <form action="login" method="post">
            <div class="mb-3">
                <input type="email" name="email" placeholder="Email" class="form-control" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" placeholder="Password" class="form-control" required>
            </div>
            <button class="btn btn-primary w-100">Login</button>
        </form>
        <p class="text-center">Don’t have an account? <a href="signup.jsp">Sign Up</a></p>
    </div>
</body>
</html>
