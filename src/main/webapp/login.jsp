<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;

        }
        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
        }
        .login-container h2 {
            margin-bottom: 1rem;
            color: #343a40;
        }
        .login-container .form-control {
            border-radius: 0.25rem;
        }
        .login-container .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.25rem;
        }
        .login-container .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .login-container .form-check-label {
            color: #6c757d;
        }
        .login-container .forgot-password {
            text-align: right;
            color: #007bff;
        }
        .login-container .forgot-password:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="./login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" placeholder="Enter your username" name="username" id="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" placeholder="Enter your password" name="password" id="password" required>
        </div>
        <div class="form-group">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" name="rememberme" id="rememberme">
                <label class="form-check-label" for="rememberme">Remember me</label>
            </div>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Login</button>
        <div class="forgot-password mt-2">
            <a href="forgotpassword.jsp">Forgot password?</a>
        </div>
    </form>
</div>

<!-- Scripts -->
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
