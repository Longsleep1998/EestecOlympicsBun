<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>

    <link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="./CSS/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container-fluid">

    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-info sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">
                            <i class="fa-solid fa-shield"></i>
                            Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="added.jsp">
                            <i class="fa-solid fa-user"> </i>
                            Register
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 main-content">
        <h2>Welcome to catalogURL</h2>
    </main>

</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
</body>
</html>
