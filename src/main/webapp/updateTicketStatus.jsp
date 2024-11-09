<%@ page import="com.example.catalog.TicketsDAO" %>
<%@ page import="java.sql.SQLException" %>
<%
    int ticketId = Integer.parseInt(request.getParameter("ticketId"));
    int newStatus = Integer.parseInt(request.getParameter("newStatus"));
    TicketsDAO ticketDAO = new TicketsDAO();
    if(newStatus==1)
    {
        boolean result = ticketDAO.updateTicketStatusAccept(ticketId, newStatus);
        response.getWriter().write(result ? "success" : "failure");

    }
    else
    {
        boolean result = ticketDAO.updateTicketStatusReject(ticketId, newStatus);
        response.getWriter().write(result ? "success" : "failure");
    }



%>
