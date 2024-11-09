<%@ page import="com.example.catalog.TicketsDAO" %>
<%@ page import="com.example.catalog.TicetsBEAN" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Current Tickets</title>
    <link rel="stylesheet" type="text/css" href="./CSS/styleticket.css">
    <script>
        function updateTicketStatus(ticketId, newStatus) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "updateTicketStatus.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    location.reload();
                }
            };
            xhr.send("ticketId=" + ticketId + "&newStatus=" + newStatus);
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Current Tickets</h1>
    <table>
        <thead>
        <tr>
            <th>Ticket ID</th>
            <th>Ticket Type</th>
            <th>Username</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            TicketsDAO ticketDAO = new TicketsDAO();
            List<TicetsBEAN> currentTickets = ticketDAO.selectAllCurrentTickets();
            for (TicetsBEAN ticket : currentTickets) {
        %>
        <tr>
            <td><%= ticket.getId() %></td>
            <td><%= ticket.getTicketType() %></td>
            <td><%= ticket.getNewUser() %></td>
            <td class="actions">
                <button onclick="updateTicketStatus(<%= ticket.getId() %>, 1)">Accept</button>
                <button onclick="updateTicketStatus(<%= ticket.getId() %>, 2)">Deny</button>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
