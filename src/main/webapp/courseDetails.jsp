<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.catalog.DatabaseCon" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.catalog.StudentDAO" %>
<%@ page import="com.example.catalog.StudentBEAN" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detalii Curs</title>
    <link rel="stylesheet" type="text/css" href="./CSS/CourseDetailsStyles.css">
    <link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    ResultSet resultSet2 = null;
    String courseName = "";
    String courseDescription = "";
%>

<%
    try {
        // Query to fetch course details
        String query = "SELECT course_name, description FROM courses WHERE id = ?";
        String query2 = "SELECT u.firstName,u.lastName,u.yearOfStudy,u.classCurrent FROM users u JOIN enrollments e WHERE u.id = e.user_id and e.course_id = ?";
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, courseId);
        PreparedStatement preparedStatement2 = con.prepareStatement(query2);
        preparedStatement2.setString(1, courseId);
        resultSet = preparedStatement.executeQuery();
        resultSet2 = preparedStatement2.executeQuery();

        if (resultSet.next()) {
            courseName = resultSet.getString("course_name");
            courseDescription = resultSet.getString("description");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}

    }
%>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-info sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#addAssignmentModal">
                            Adauga Assignment
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#gradeStudentModal">
                            Nota Studenti
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#enrollmentModal">
                            Inrolare Studenti
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#studentManagementModal">
                            ManagementStudents
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="landingTeacher.jsp" >
                            Inapoi la Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#studentSituationModal" >
                            Vezi Studenti Inrolati
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp" >
                            Delogare
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 main-content">
            <h2><%= courseName %></h2>
            <p><%= courseDescription %></p>
            <div class="container">


            </div>
        </main>
    </div>
</div>

<!-- Add Assignment Modal -->

<div class="modal fade" id="addAssignmentModal" tabindex="-1" role="dialog" aria-labelledby="addAssignmentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAssignmentModalLabel">Adauga Assignment</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="addAssignmentServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="courseId" value="<%= courseId %>">
                    <label for="assignmentName">Numele Assignment:</label>
                    <input type="text" id="assignmentName" name="assignmentName" class="form-control" required><br>

                    <label for="dueDate">Data Limita:</label>
                    <input type="date" id="dueDate" name="dueDate" class="form-control" required><br>

                    <label for="assignmentDescription">Descriere:</label>
                    <textarea id="assignmentDescription" name="assignmentDescription" class="form-control" required></textarea><br>

                    <label for="file">Incarca Material:</label>
                    <input type="file" id="file" name="file" class="form-control" required><br>

                    <button type="submit" class="btn btn-primary">Adauga Assignment</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Grade Student Modal -->

<div class="modal fade" id="gradeStudentModal" tabindex="-1" role="dialog" aria-labelledby="gradeStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="gradeStudentModalLabel">Nota Studenti</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="gradeStudentServlet" method="post">
                    <input type="hidden" name="courseId" value="<%= courseId %>">
                    <label for="studentId">ID Student:</label>
                    <input type="text" id="studentId" name="studentId" class="form-control" required><br>

                    <label for="grade">Nota:</label>
                    <input type="text" id="grade" name="grade" class="form-control" required><br>

                    <label for="assignmentId">ID Assignment:</label>
                    <input type="text" id="assignmentId" name="assignmentId" class="form-control" required><br>

                    <button type="submit" class="btn btn-primary">Da Nota</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Enrollment Modal -->

<div class="modal fade" id="enrollmentModal" tabindex="-1" role="dialog" aria-labelledby="enrollmentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="enrollmentModalLabel">Inrolare Studenti</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="./enrollment" method="post">
                    <input type="hidden" name="courseId" value="<%= courseId %>">
                    <label for="student-name">Nume Student:</label>
                    <input type="text" id="student-name" name="student-name" class="form-control" required><br>

                    <button type="submit" class="btn btn-primary">Inroleaza</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal cu studentii inrolati -->

<div class="modal fade" id="studentSituationModal" tabindex="-1" role="dialog" aria-labelledby="studentSituationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="studentSituationModalLabel">Studenti Participanti</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <dl>
                    <%

                        // Loop through the result set and print course details
                        while (resultSet2.next()) {
                            String firstName = resultSet2.getString("firstName");
                            String lastName = resultSet2.getString("lastName");
                            String yearOfStudy = resultSet2.getString("yearOfStudy");
                            String classCurrent = resultSet2.getString("classCurrent");
                    %>
                    <dt><%=firstName+" "+lastName%></dt>
                    <dd>Year of Study: <%=yearOfStudy%> Class: <%=classCurrent%></dd>
                    <%
                        }
                    %>
                </dl>
                </div>
        </div>
    </div>
</div>
<!-- Student management Modal -->
<!-- Student management Modal -->
<div class="modal fade" id="studentManagementModal" tabindex="-1" role="dialog" aria-labelledby="studentManagementModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="studentManagementModalLabel">Manage Students Enrollment</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" id="searchInputModal" onkeyup="myFunction()" placeholder="Search by first name" class="form-control mb-3">
                <table id="studentTableModal" class="table table-bordered">
                    <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Year of Study</th>
                        <th>Class</th>
                        <th style="display: none"></th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        StudentDAO studentDAO = new StudentDAO();
                        List<StudentBEAN> currentStudents = studentDAO.allenrolledstudents(Integer.parseInt(courseId));
                        List<StudentBEAN> currentStudents2 = studentDAO.allunenrolledstudents(Integer.parseInt(courseId));
                        currentStudents.addAll(currentStudents2);
                        for (StudentBEAN student : currentStudents) {
                    %>
                    <tr>
                        <td><%= student.getFirstName() %></td>
                        <td><%= student.getLastName() %></td>
                        <td><%= student.getYearOfStudy() %></td>
                        <td><%= student.getClassCurrent() %></td><!-- DE CE SFINTI DACA LAS DOAR CLASA IMI APAR TOATE NULE IN FORM -->
                        <td style="display: none"><%= student.getId()%></td>
                        <td>
                        <form action="./studentmanagement" method="post" style="display:inline;">
                            <input type="hidden" name="studentId1" value="<%= student.getId() %>">
                            <input type="hidden" name="courseId1" value="<%= courseId %>">
                            <input type="hidden" name="action1" value="<%= student.getAction() %>">
                            <button type="submit" class="btn btn-primary"><%= student.getAction()%></button>
                        </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    var app = {
        settings: {
            container: $('.calendar'),
            calendar: $('.front'),
            days: $('.weeks span'),
            form: $('.back'),
            input: $('.back input'),
            buttons: $('.back button')
        },

        init: function() {
            instance = this;
            settings = this.settings;
            this.bindUIActions();
        },

        swap: function(currentSide, desiredSide) {
            settings.container.toggleClass('flip');

            currentSide.fadeOut(900);
            currentSide.hide();
            desiredSide.show();

        },

        bindUIActions: function() {
            settings.days.on('click', function(){
                instance.swap(settings.calendar, settings.form);
                settings.input.focus();
            });

            settings.buttons.on('click', function(){
                instance.swap(settings.form, settings.calendar);
            });
        }
    }

    app.init();
    const monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"];

    const currentDate = new Date();
    let currentMonth = currentDate.getMonth();
    let currentYear = currentDate.getFullYear();

    const monthSelect = document.getElementById('month-select');
    const yearSelect = document.getElementById('year-select');
    const currentDateElem = document.getElementById('current-date');
    const weeksContainer = document.getElementById('weeks-container');

    function populateMonthSelect() {
        monthNames.forEach((month, index) => {
            const option = document.createElement('option');
            option.value = index;
            option.textContent = month;
            if (index === currentMonth) {
                option.selected = true;
            }
            monthSelect.appendChild(option);
        });
    }

    function populateYearSelect() {
        for (let year = currentYear - 5; year <= currentYear + 5; year++) {
            const option = document.createElement('option');
            option.value = year;
            option.textContent = year;
            if (year === currentYear) {
                option.selected = true;
            }
            yearSelect.appendChild(option);
        }
    }

    function formatDay(day) {
        return day < 10 ? '0' + day : day;
    }

    function updateCalendar() {
        const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
        const firstDay = new Date(currentYear, currentMonth, 1).getDay();
        const lastMonthDays = new Date(currentYear, currentMonth, 0).getDate();

        currentDateElem.textContent = `${monthNames[currentMonth]} ${currentYear}`;

        weeksContainer.innerHTML = '';

        let dayCounter = 1;
        let nextMonthCounter = 1;
        for (let i = 0; i < 6; i++) {
            const weekRow = document.createElement('div');
            weekRow.classList.add('week');
            for (let j = 0; j < 7; j++) {
                const dayCell = document.createElement('span');
                dayCell.classList.add('current-month-day');
                if (i === 0 && j < firstDay) {
                    dayCell.textContent = formatDay(lastMonthDays - (firstDay - j - 1));
                    dayCell.classList.add('last-month');
                } else if (dayCounter > daysInMonth) {
                    dayCell.textContent = formatDay(nextMonthCounter++);
                    dayCell.classList.add('next-month');
                } else {
                    dayCell.textContent = formatDay(dayCounter++);
                }
                weekRow.appendChild(dayCell);
            }
            weeksContainer.appendChild(weekRow);
        }
    }


    monthSelect.addEventListener('change', (event) => {
        currentMonth = parseInt(event.target.value);
        updateCalendar();
    });

    yearSelect.addEventListener('change', (event) => {
        currentYear = parseInt(event.target.value);
        updateCalendar();
    });

    document.addEventListener('DOMContentLoaded', () => {
        populateMonthSelect();
        populateYearSelect();
        updateCalendar();
    });
</script>
<script>
    function myFunction() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInputModal");
        filter = input.value.toUpperCase();
        table = document.getElementById("studentTableModal");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

</body>
</html>
