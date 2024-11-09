package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class ForgotPasswordServlet extends HttpServlet
{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {


            Connection con = DatabaseCon.initializeDatabase();
            PreparedStatement st = con.prepareStatement("insert into tickets(UserIDSolicitant,TicketType,Status,NewUser,NewPassword) select u.ID,tt.ID_TicketType,'0',?,? from users u JOIN ticketstype tt ON tt.RequestType = ? where u.username=?");

            st.setString(1,request.getParameter("username"));
            st.setString(2,request.getParameter("password"));
            st.setString(3,"PasswordChange");
            st.setString(4, request.getParameter("username"));
            st.executeUpdate();
            st.close();
            con.close();
            PrintWriter out = response.getWriter();
            out.println("<html><body><b>Successfully submitted the ticket</b><br><a href=\"login.jsp\">Login</a><br></body></html>");



            //String username = request.getParameter("username");
            //String password = request.getParameter("password");
            //String role = request.getParameter("role");
            //AddUser.addUser(id, username, password, role);
            //response.sendRedirect("addedSuccessfuly.jsp");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

}

