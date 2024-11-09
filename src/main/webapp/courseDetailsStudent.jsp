<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.catalog.DatabaseCon" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="./CSS/styles.css">
<link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<head>
    <title>Detalii Curs</title>
    <!--<link rel="stylesheet" type="text/css" href="./CSS/CourseDetailsStyles.css">-->


</head>
<body>
<%
    String courseId = request.getParameter("courseId");

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
    String courseName = "";
    String courseDescription = "";
%>

<%
    try {
        // Query to fetch course details
        String query = "SELECT course_name, description FROM courses WHERE id = ?";
        statement = con.prepareStatement(query);
        ((PreparedStatement) statement).setString(1, courseId);
        resultSet = ((PreparedStatement) statement).executeQuery();

        if (resultSet.next()) {
            courseName = resultSet.getString("course_name");
            courseDescription = resultSet.getString("description");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
    }
%>
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
                        <a class="nav-link" href="#" id="enrollmentStudent">
                            <i class="fa-solid fa-book"></i>
                            Materiale Incarcate
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#notestudent">
                            <i class="fa-solid fa-0"></i>
                            Note
                        </a>
                    </li>
                    <li style="margin-top: 145%" class="nav-item">
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
    <h1 style="margin-top: 20px; margin-left: 280px; color:antiquewhite"> <%= courseName%>!</h1>
    <h3 style="margin-top: 50px; margin-left: 280px; color:antiquewhite"><%= courseDescription%></h3>
    <h3 style="margin-top: 50px; margin-left: 280px; color:antiquewhite">Vizualizare Note</h3>
    <h3 style="margin-top: 50px; margin-left: 280px; color:antiquewhite">Materiale Incarcate</h3>

<ul style="margin-left: 280px">
    <%
        try {
            // Query to fetch assignments for the course
            String query = "SELECT id, assignment_name, due_date FROM assignments WHERE course_id = ?";
            statement = con.prepareStatement(query);
            ((PreparedStatement) statement).setString(1, courseId);
            resultSet = ((PreparedStatement) statement).executeQuery();

            while (resultSet.next()) {
                String assignmentId = resultSet.getString("id");
                String assignmentName = resultSet.getString("assignment_name");
                String dueDate = resultSet.getString("due_date");
    %>
    <li>
        <b><%= assignmentName %></b> - <%= dueDate %><br>
        <a href="downloadAssignmentServlet?assignmentId=<%= assignmentId %>" class="btn btn-primary">Download Material</a>
        <button class="btn btn-primary" onclick="viewPDF('<%= assignmentId %>')">View</button>
    </li>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (con != null) try { con.close(); } catch (SQLException ignore) {}
        }
    %>
</ul>
</main>
</div>
<!-- Modal for Viewing PDF -->
<div class="modal fade" id="pdfModal" tabindex="-1" role="dialog" aria-labelledby="pdfModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="pdfModalLabel">PDF Viewer</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <iframe id="pdfFrame" src="" width="100%" height="500px"></iframe>
            </div>
        </div>
    </div>
</div>

<!-- Script to view the pdf file -->

<script type="text/javascript">
    function viewPDF(assignmentId) {
        var iframe = document.getElementById("pdfFrame");
        iframe.src = "viewAssignmentServlet?assignmentId=" + assignmentId;
        $('#pdfModal').modal('show');
    }
</script>

</body>
</html>

