<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .forgot-password-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .forgot-password-container h2 {
            margin-bottom: 1rem;
            color: #343a40;
        }
        .forgot-password-container .form-control {
            border-radius: 0.25rem;
        }
        .forgot-password-container .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.25rem;
        }
        .forgot-password-container .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .forgot-password-container .form-check-label {
            color: #6c757d;
        }
        .forgot-password-container .cancel-link {
            text-align: right;
            color: #007bff;
        }
        .forgot-password-container .cancel-link:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="forgot-password-container">
    <h2>Forgot Password</h2>
    <form action="./forgotpassword" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" placeholder="Enter your username" name="username" id="username" required>
        </div>
        <div class="form-group">
            <label for="password">New Password</label>
            <input type="password" class="form-control" placeholder="Enter your new password" name="password" id="password" required>
        </div>
        <div class="form-group">
            <label for="confirm_password">Confirm New Password</label>
            <input type="password" class="form-control" placeholder="Confirm your new password" name="confirm_password" id="confirm_password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Submit</button>
        <div class="cancel-link mt-2">
            <a href="login.jsp">Cancel</a>
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
<script>
    var password = document.getElementById("password"),
        confirm_password = document.getElementById("confirm_password");

    function validatePassword(){
        if(password.value !== confirm_password.value) {
            confirm_password.setCustomValidity("Passwords Don't Match");
        } else {
            confirm_password.setCustomValidity('');
        }
    }

    password.onchange = validatePassword;
    confirm_password.onkeyup = validatePassword;
</script>
</body>
</html>
