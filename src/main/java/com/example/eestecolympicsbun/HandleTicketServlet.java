package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class HandleTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketId = request.getParameter("ticketId");
        String action = request.getParameter("action");

        try {
            Connection con = DatabaseCon.initializeDatabase();
            con.setAutoCommit(false);

            if ("accept".equals(action)) {
                // Implementare pentru acceptare ticket
                PreparedStatement st = con.prepareStatement("UPDATE tickets SET status = 1 WHERE ID_Ticket = ?");
                st.setString(1, ticketId);
                st.executeUpdate();
                st.close();
            } else if ("reject".equals(action)) {
                // Implementare pentru respingere ticket
                PreparedStatement st = con.prepareStatement("UPDATE tickets SET status = -1 WHERE ID_Ticket = ?");
                st.setString(1, ticketId);
                st.executeUpdate();
                st.close();
            }

            con.commit();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

