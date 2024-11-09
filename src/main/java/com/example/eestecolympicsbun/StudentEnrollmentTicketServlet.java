package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class StudentEnrollmentTicketServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Connection con = DatabaseCon.initializeDatabase();
            PreparedStatement st = con.prepareStatement("insert into tickets(UserIDSolicitant,TicketType,Status,CourseID) select u.ID,tt.ID_TicketType,'0',c.id from users u JOIN ticketstype tt JOIN courses c ON tt.RequestType = ? where u.firstName=? and u.lastName=? and c.course_name=?");
            st.setString(1,"Student Enrollment");
            st.setString(2,request.getParameter("firstName"));
            st.setString(3,request.getParameter("lastName"));
            st.setString(4, request.getParameter("courseName"));
            st.executeUpdate();
            st.close();
            con.close();

            response.sendRedirect("landingStudent.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }



}
