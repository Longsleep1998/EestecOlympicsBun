
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Adauga Curs</title>
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
        .add-course-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1);
        }
        .add-course-container h2 {
            margin-bottom: 1rem;
            color: #343a40;
        }
        .add-course-container .form-control {
            border-radius: 0.25rem;
        }
        .add-course-container .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 0.25rem;
        }
        .add-course-container .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .add-course-container .form-check-label {
            color: #6c757d;
        }
        .add-course-container .forgot-password {
            text-align: right;
            color: #007bff;
        }
        .add-course-container .forgot-password:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="add-course-container">
    <h2>Adaugati un Curs</h2>
    <form action="./addCourseServlet" method="post">
        <div class="form-group">
            <label for="courseName">Numele Cursului</label>
            <input type="text" class="form-control" placeholder="Enter course name" name="courseName" id="courseName" required>
        </div>
        <div class="form-group">
            <label for="courseType">Tip:</label>
            <select id="courseType" name="courseType">
                <option value="Curs">Curs</option>
                <option value="Seminar">Seminar</option>
            </select><br>
        </div>
        <div class="form-group">

                <label for="courseYear">Anul Destinatar și Seria:</label>
                <input type="text" id="courseYear" name="courseYear" required><br>

        </div>
        <button type="submit" class="btn btn-primary btn-block">Adauga Curs</button>
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
