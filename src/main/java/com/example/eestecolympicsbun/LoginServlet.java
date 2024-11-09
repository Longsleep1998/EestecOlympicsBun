package com.example.catalog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean user = new UserBean();
        user.setUsername(request.getParameter("username"));
        try {
            user.setPassword(hashMessage(request.getParameter("password")));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        user=UserDAO.login(user);

        // Authenticate user (this is a simplified example)
        if (user.isValid() ) {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("username", user.getUsername());
            if(user.getRole()==3)
                request.getRequestDispatcher("landingTeacher.jsp").forward(request, response);
            if(user.getRole()==2)
                request.getRequestDispatcher("landingStudent.jsp").forward(request, response);
            if(user.getRole()==1)
                request.getRequestDispatcher("landingAdmin.jsp").forward(request, response);
        } else {

            PrintWriter out = response.getWriter();
            out.println("<html><body><b>Failed to login</b></body></html>");

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
