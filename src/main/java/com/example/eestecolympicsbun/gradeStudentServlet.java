package com.example.catalog;

import com.example.catalog.DatabaseCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static java.lang.System.out;

@MultipartConfig
@WebServlet("/gradeStudentServlet")
public class gradeStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("courseId");
        String studentId = request.getParameter("studentId");
        String grade = request.getParameter("grade");
        String assignment = request.getParameter("assignment_id");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseCon.initializeDatabase();
            String query = "INSERT INTO grades (user_id, course_id, grade, assignment_id) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, studentId);
            ps.setString(2, courseId);
            ps.setString(3, grade);
            ps.setInt(4, Integer.parseInt(assignment));
            ps.executeUpdate();
            PrintWriter out = response.getWriter();

            out.println("<html><body><br><a href=\"courseDetails.jsp?courseId=\" + courseId\">Revenire la Curs</a><br></body></html>");
           // response.sendRedirect("courseDetails.jsp?courseId=" + courseId);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while assigning the grade.");
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
