package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addCourseServlet")
public class addCourseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseName = request.getParameter("courseName");
        String courseType = request.getParameter("courseType");
        String courseYear = request.getParameter("courseYear");
        String courseDescription = courseType + " - " + courseYear;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Initialize database connection
            con = DatabaseCon.initializeDatabase();

            // Insert course into database
            String query = "INSERT INTO courses (course_name, description) VALUES (?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, courseName);
            ps.setString(2, courseDescription);
            ps.executeUpdate();

            // Redirect to the page showing courses
            response.sendRedirect("landingTeacher.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the course.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
