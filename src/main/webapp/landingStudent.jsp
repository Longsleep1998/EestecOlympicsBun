<%@ page import="com.example.catalog.DatabaseCon" %>
<%@ page import="com.example.catalog.UserBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.Period" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="./CSS/CourseDetailsStyles.css">
    <link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <link rel="stylesheet" type="text/css" href="./CSS/styles.css">
    <!--<link rel="stylesheet" type="text/css" href="./CSS/styleticket.css">-->
    <title>Landing Page Student</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-info sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <span data-feather="home"></span>
                            <i class="fa-solid fa-bars"></i>
                            Dashboard <span class="sr-only"></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#showCoursesModal">
                            <i class="fa-solid fa-book"></i>
                            Cursuri
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#enrollmentStudentModal">
                            <i class="fa-solid fa-check"></i>
                            Aplica Pentru Inrolare
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#notificari">
                            <i class="fa-solid fa-bell"></i>
                            Notificari
                        </a>
                    </li>
                    <li style="margin-top: 140%" class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <i class="fa-solid fa-shield"></i>
                            Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        // Redirect to login page or show an error message
        response.sendRedirect("login.jsp");
        return;
    }
    Connection connection1=DatabaseCon.initializeDatabase();
    PreparedStatement preparedStatement1 = connection1.prepareStatement("SELECT firstName FROM users WHERE username = ?");
    preparedStatement1.setString(1, username);
    ResultSet resultSet1 = preparedStatement1.executeQuery();
    resultSet1.next();
    String firstName = resultSet1.getString(1);
    resultSet1.close();
    preparedStatement1.close();
    connection1.close();
%>
                <h1 style="margin-top: 20px; margin-left: 280px; color:antiquewhite">Welcome, <%= firstName%>!</h1>
                <h3 style="margin-top: 50px; margin-left: 280px; color:antiquewhite">Cursurile Tale:</h3>
                <%
                Connection con = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;
                try {
                    con = DatabaseCon.initializeDatabase();

                    // Query to fetch courses
                     String query = "SELECT courses.id, courses.course_name, courses.description FROM courses " +
                    "JOIN enrollments ON courses.id = enrollments.course_id " +
                    "JOIN users ON enrollments.user_id = users.id " +
                    "WHERE users.username = ?";
                preparedStatement = con.prepareStatement(query);
                preparedStatement.setString(1, username);

                resultSet = preparedStatement.executeQuery();
%>
                <dl style="margin-left: 285px">
                    <%
                        // Loop through the result set and print course details
                        while (resultSet.next()) {
                            String courseId = resultSet.getString("id");
                            String courseName = resultSet.getString("course_name");
                            String courseDescription = resultSet.getString("description");
                    %>
                    <dt style="color: antiquewhite"><a href="courseDetailsStudent.jsp?courseId=<%= courseId %>"><%= courseName %></a></dt>
                    <dd style="color: antiquewhite"><%= courseDescription %></dd>
                    <%
                        }
                    %>
                </dl>

                <h3 style="margin-left: 280px; margin-top: 30px; color: antiquewhite">Inscriere Student la Curs</h3>
                <form style="margin-left: 280px" action="./studentenrollment" method="post">

                    <label for="courseName">Introduce numele cursului:</label>
                    <input type="text" id="courseName" name="courseName" required><br>

                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" required><br>

                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" required><br>

                    <button type="submit">Trimite Ticket</button>
                </form>
                    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</div>
<!-- Arata Cursuri Modal -->
<%
    Connection con1 = null;
    PreparedStatement preparedStatement2 = null;
    ResultSet resultSet2 = null;
    try {
        con1 = DatabaseCon.initializeDatabase();

        // Query to fetch courses
        String query = "SELECT courses.id, courses.course_name, courses.description FROM courses " +
                "JOIN enrollments ON courses.id = enrollments.course_id " +
                "JOIN users ON enrollments.user_id = users.id " +
                "WHERE users.username = ?";
        preparedStatement2 = con.prepareStatement(query);
        preparedStatement2.setString(1, username);

        resultSet2 = preparedStatement2.executeQuery();
%>
<div class="modal fade" id="showCoursesModal" tabindex="-1" role="dialog" aria-labelledby="showCoursesModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="showCoursesModalLabel">Vezi Cursuri</h5>
                <button style="align-items: end" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <dl>
                    <%

                        // Loop through the result set and print course details
                        while (resultSet2.next()) {
                            String courseId = resultSet2.getString("id");
                            String courseName = resultSet2.getString("course_name");
                            String courseDescription = resultSet2.getString("description");
                    %>
                    <dt style="color: antiquewhite"><a href="courseDetailsStudent.jsp?courseId=<%= courseId %>"><%= courseName %></a></dt>
                    <dd style="color: antiquewhite"><%= courseDescription %></dd>
<% } %>
                </dl>


            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}

    }
%>
<!--Notificari Modal -->

<%
    Connection con3 = null;
    PreparedStatement preparedStatement3 = null;
    ResultSet resultSet3 = null;
    try {
        con3 = DatabaseCon.initializeDatabase();

        // Query to fetch assignments
        String query3 = "SELECT assignments.assignment_name , assignments.due_date , assignments.course_id FROM assignments " +
                "JOIN enrollments ON assignments.course_id = enrollments.course_id " +
                "JOIN users ON enrollments.user_id = users.id " +
                "WHERE users.username = ?";
        preparedStatement3 = con3.prepareStatement(query3);
        preparedStatement3.setString(1, username);

        resultSet3 = preparedStatement3.executeQuery();
%>
<div class="modal fade" id="notificari" tabindex="-1" role="dialog" aria-labelledby="notificariLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notificariLabel">Notificari Curente</h5>
                <button style="align-items: end" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <dl>
                    You have upcoming assignments:
                    <%

                        // Loop through the result set and print course details
                        String assignment_name = null;
                        String assignment_date = null;
                        while (resultSet3.next()) {
                            assignment_name = resultSet3.getString("assignment_name");
                            assignment_date = resultSet3.getString("due_date");
                            String course_id = resultSet3.getString("course_id");

                        Period difference = Period.between(LocalDate.parse(assignment_date),java.time.LocalDate.now());
                        if(difference.getDays()<0){
                    %>

                    <dt><%=assignment_name%></dt>
                    <dt><%=assignment_date%></dt>
                    <dt>There are <%=-difference.getDays() %> days left</dt>
                    <% }} %>
                </dl>


            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}

    }
%>
<!-- APlica pentru inrolare Modal -->
<div class="modal fade" id="enrollmentStudentModal" tabindex="-1" role="dialog" aria-labelledby="enrollmentStudentLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="enrollmentStudent2">Aplica pentru un curs</h5>
                <button style="align-items: end" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="./studentenrollment" method="post">

                    <label for="courseName2">Introduce numele cursului:</label>
                    <input type="text" id="courseName2" name="courseName" required><br>

                    <label for="firstName2">First Name:</label>
                    <input type="text" id="firstName2" name="firstName" required><br>

                    <label for="lastName2">Last Name:</label>
                    <input type="text" id="lastName2" name="lastName" required><br>

                    <button type="submit">Trimite Ticket</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>