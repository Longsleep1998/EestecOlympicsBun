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
import java.sql.SQLException;

@WebServlet(name="EnrollmentStudentServlet", value = "/enrollment")
public class EnrollmentStudentServlet extends HttpServlet
{
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try {
            Connection con= DatabaseCon.initializeDatabase();
            PreparedStatement statement=con.prepareStatement("insert into enrollments(user_id,course_id) select id ,? from users where users.username=? ");
            statement.setString(2,request.getParameter("student-name"));
            statement.setString(1,request.getParameter("courseId"));
            statement.executeUpdate();
            statement.close();
            con.close();
            PrintWriter out = response.getWriter();
            out.println("<html><body><b>Student Adaugat cu success</b><br><b>Inapoi la curs</b><a href=\"courseDetails.jsp\">Inapoi la curs</a><br></body></html>");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
