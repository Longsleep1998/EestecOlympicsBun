<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page import="com.example.catalog.DatabaseCon" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="./CSS/styles.css">
<link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<body>


<%
    Connection con = null;
    try {
        con = DatabaseCon.initializeDatabase();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
    Statement statement = null;
    ResultSet resultSet = null;
%>

<%
    try {

        // Query to fetch courses
        String query = "SELECT id, course_name, description FROM courses";
        statement = con.createStatement();
        resultSet = statement.executeQuery(query);
%>
<div class="container-fluid">

    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-info sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#showCoursesModal">
                            <i class="fa-solid fa-book"></i>
                            Vezi Cursuri
                        </a>
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#addCourseModal">
                            <i class="fa-solid fa-plus"></i>
                            Adauga un un curs
                        </a>
                        <a class="nav-link" href="login.jsp" >
                            <i class="fa-solid fa-shield"></i>
                            Delogare
                        </a>

                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>

<!-- Arata Cursuri Modal -->
<div class="modal fade" id="showCoursesModal" tabindex="-1" role="dialog" aria-labelledby="showCoursesModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="showCoursesModalLabel">Vezi Cursuri</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <dl>
                <%

                    // Loop through the result set and print course details
                    while (resultSet.next()) {
                        String courseId = resultSet.getString("id");
                        String courseName = resultSet.getString("course_name");
                        String courseDescription = resultSet.getString("description");
                %>
                <dt><a href="courseDetails.jsp?courseId=<%=courseId%>"><%=courseName%></a></dt>
                <dd><%=courseDescription%></dd>
                <%
                    }
                %>
                </dl>
                <%
                        // End of the description list

                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                        if (con != null) try { con.close(); } catch (SQLException ignore) {}
                    }
                %>
                <!-- Buton pentru adăugarea unui curs -->
                <form action="addCourse.jsp" method="get">
                    <button type="submit" class="btn btn-primary">Adauga Curs</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Adauga un Curs Modal -->

<div class="modal fade" id="addCourseModal" tabindex="-1" role="dialog" aria-labelledby="addCourseModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCourseModalLabel">Adauga Cursuri</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Buton pentru adăugarea unui curs -->
                <form action="addCourse.jsp" method="get">
                    <button type="submit" class="btn btn-primary">Adauga Curs</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
