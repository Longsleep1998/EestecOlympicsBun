<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--<link rel="stylesheet" type="text/css" href="./CSS/CourseDetailsStyles.css">-->
    <link href="${pageContext.request.contextPath}/css-bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="./CSS/styles.css">
    <link rel="stylesheet" type="text/css" href="./CSS/styleticket.css">
    <title>Landing Page Administrator</title>
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
                            Dashboard <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="view-current-tickets">
                            Current Tickets
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="view-old-tickets">
                            Old Tickets
                        </a>
                    </li>
                    <li style="margin-top: 150%" class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <i class="fa-solid fa-shield"></i>
                            Logout
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <h2>Tickets</h2>
            <div id="ticket-table-container" style="margin: 20px 0 0 120px; !important">

                <!-- Aici se va încărca tabelul cu tickete -->

            </div>
        </main>
    </div>
</div>

<script>
    $(document).ready(function(){
        $('#view-current-tickets').click(function(){
            $('#ticket-table-container').load('currentTickets.jsp');
        });

        $('#view-old-tickets').click(function(){
            $('#ticket-table-container').load('oldTickets.jsp');
        });
    });

    function handleTicket(ticketId, action) {
        $.ajax({
            url: 'handleTicket',
            type: 'POST',
            data: {
                ticketId: ticketId,
                action: action
            },
            success: function(response) {
                $('#ticket-row-' + ticketId).remove();
            }
        });
    }
</script>
</body>
</html>
