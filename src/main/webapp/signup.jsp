<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Body & Background */
        body {
            background: linear-gradient(135deg, #f6f8fc, #e0e7ff, #fff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Inter', sans-serif;
            margin: 0;
            color: #333;
        }

        /* Card */
        .card {
            background: #ffffff;
            border-radius: 16px;
            padding: 2.5rem 2rem;
            width: 400px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        h3 {
            text-align: center;
            font-weight: 600;
            margin-bottom: 2rem;
            font-size: 1.8rem;
            color: #333;
        }

        /* Form Inputs */
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            background: #f9fafb;
            color: #333;
            font-weight: 500;
            transition: all 0.3s;
        }

        .form-control::placeholder {
            color: #a1a1aa;
        }

        .form-control:focus {
            outline: none;
            border-color: #6366f1;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.2);
        }

        /* Button */
        .btn-success {
            background: linear-gradient(135deg, #6ee7b7, #3b82f6);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s;
            color: #fff;
        }

        .btn-success:hover {
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
        <h3>Create Account</h3>
        <form action="signup" method="post">
            <div class="mb-3">
                <input type="text" name="name" placeholder="Full Name" class="form-control" required>
            </div>
            <div class="mb-3">
                <input type="email" name="email" placeholder="Email" class="form-control" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" placeholder="Password" class="form-control" required>
            </div>
            <button class="btn btn-success w-100">Sign Up</button>
        </form>
        <p class="text-center mt-3">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>
