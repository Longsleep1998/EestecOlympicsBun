<%@ page import="com.example.catalog.TicketsDAO" %>
<%@ page import="com.example.catalog.TicetsBEAN" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Completed Tickets</title>
    <link rel="stylesheet" type="text/css" href="./CSS/styleticket.css">
</head>
<body>
<div class="container">
    <h1>Completed Tickets</h1>
    <table>
        <thead>
        <tr>
            <th>Ticket ID</th>
            <th>Ticket Type</th>
            <th>Username</th>
            <th>Status(1- Accepted/2-Rejected)</th>
        </tr>
        </thead>
        <tbody>
        <%
            TicketsDAO ticketDAO = new TicketsDAO();
            List<TicetsBEAN> oldTickets = ticketDAO.selectAllOldTickets();
            for (TicetsBEAN ticket : oldTickets) {
        %>
        <tr>
            <td><%= ticket.getId() %></td>
            <td><%= ticket.getTicketType() %></td>
            <td><%= ticket.getNewUser() %></td>
            <td><%= ticket.getStatus()%></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

