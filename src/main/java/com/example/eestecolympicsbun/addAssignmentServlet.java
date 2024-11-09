package com.example.catalog;

import com.example.catalog.DatabaseCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@MultipartConfig
@WebServlet("/addAssignmentServlet")
public class addAssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("courseId");
        String assignmentName = request.getParameter("assignmentName");
        String dueDate = request.getParameter("dueDate");
        String assignmentDescription = request.getParameter("assignmentDescription");
        InputStream inputStream=null;
        Part filePart = request.getPart("file");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseCon.initializeDatabase();
            String query = "INSERT INTO assignments (course_id, assignment_name, due_date, description) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, courseId);
            ps.setString(2, assignmentName);
            ps.setString(3, dueDate);

            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                ps.setBlob(4, inputStream);
            }

            // sends the statement to the database server
            int row = ps.executeUpdate();
            if (row > 0) {
                PrintWriter out = response.getWriter();
                out.println("<html><body><b>\"File uploaded and saved into database\"</b><br></body></html>");
            }
            //ps.executeUpdate();

            // Save the file (this example just saves the file name)
            //inputStream = filePart.getInputStream();
            // Save fileContent to the desired location

            response.sendRedirect("courseDetails.jsp?courseId=" + courseId);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while adding the assignment.");
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
