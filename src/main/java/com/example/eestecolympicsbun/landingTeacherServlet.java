package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

public class landingTeacherServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try {
            Connection con=DatabaseCon.initializeDatabase();

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
