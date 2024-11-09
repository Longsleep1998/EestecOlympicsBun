package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class landingAdminServlet extends HttpServlet
{
    public String hashMessage(String message) throws NoSuchAlgorithmException {
        final MessageDigest digest = MessageDigest.getInstance("SHA3-256");
        final byte[] hashBytes = digest.digest(message.getBytes(StandardCharsets.UTF_8));
        return bytesToHex(hashBytes);
    }

    private static String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder(2 * hash.length);
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            Connection con=DatabaseCon.initializeDatabase();
                // Start transaction
                con.setAutoCommit(false);

                // First update statement
                PreparedStatement st1 = con.prepareStatement("UPDATE users u INNER JOIN tickets t ON u.ID = t.UserIDSolicitant SET u.username = ?, u.password = ? WHERE u.username = ?");
                st1.setString(1, request.getParameter("usernamenew"));
                st1.setString(2, hashMessage(request.getParameter("passwordnew")));
                st1.setString(3, request.getParameter("usernamenew"));
                st1.executeUpdate();
                st1.close();

                // Second update statement
                PreparedStatement st2 = con.prepareStatement("UPDATE tickets SET status = '1' WHERE ID_Ticket = ?");
                st2.setString(1, request.getParameter("ticketID"));
                st2.executeUpdate();
                st2.close();

                // Commit transaction
                con.commit();
            con.close();
            PrintWriter out = response.getWriter();
            out.println("<html><body><b>Successfully Updated</b><br><a href=\"login.jsp\">Login</a><br></body></html>");


        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
