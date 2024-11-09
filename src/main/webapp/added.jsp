<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <!--<link rel="stylesheet" type="text/css" href="./CSS/CourseDetailsStyles.css">-->
    <link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;

        }
        .register-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .register-container h2 {
            margin-bottom: 1rem;
            color: #343a40;
        }
        .register-container .form-control {
            border-radius: 0.25rem;
        }
        .register-container .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.25rem;
        }
        .register-container .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .register-container .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            border-radius: 0.25rem;
        }
        .register-container .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .register-container .form-check-label {
            color: #6c757d;
        }
        .register-container .cancel-link {
            text-align: right;
            margin-top: 1rem;
        }
        .register-container .cancel-link a {
            color: #007bff;
        }
        .register-container .cancel-link a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2>Register</h2>
    <form action="./add-user" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
        </div>
        <div class="form-group">
            <label for="role">Role</label>
            <select class="form-control" id="role" name="role" onchange="checkOption(this)">
                <option value="" disabled selected>Select Role</option>
                <option value="Student">Student</option>
                <option value="Teacher">Teacher</option>
            </select>
        </div>
        <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter your First Name" required>
        </div>
        <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter your Last Name" required>
        </div>
        <div class="form-group">
            <label for="yearOfStudy">Year of Study</label>
            <input type="text" class="form-control" id="yearOfStudy" name="yearOfStudy" placeholder="Enter your current year of study" disabled>
        </div>
        <div class="form-group">
            <label for="classCurrent">Current Class</label>
            <input type="text" class="form-control" id="classCurrent" name="classCurrent" placeholder="Enter your current class" disabled>
        </div>
        <div class="form-group">
            <label for="Email">Email</label>
            <input type="text" class="form-control" id="Email" name="Email" placeholder="Enter your Email here" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Register</button>
        <button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">Cancel</button>
        <div class="cancel-link">
            <a href="login.jsp">Back to Login</a>
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
<script type = "text/javascript">
    function checkOption(obj) {
        if (obj.value === "Student") {
            $("#yearOfStudy").prop("disabled", false);
            $("#classCurrent").prop("disabled", false);
        } else {
            $("#yearOfStudy").prop("disabled", true);
            $("#classCurrent").prop("disabled", true);
        }
    }
    $(document).ready(function() {
        checkOption(document.getElementById("role"));
    });
</script>