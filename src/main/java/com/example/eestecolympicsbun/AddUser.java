package com.example.catalog;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddUser {
    private static final String URL = "jdbc:mysql://localhost:3306/catalog/user";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    public static void addUser(String id, String username, String password, String role) {
        System.out.println("OK");
        String sql = "INSERT INTO users (id, username, password, role) VALUES (?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, id);
            statement.setString(2, username);
            statement.setString(3, password);
            statement.setString(4, role);
            int rowsInserted = statement.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);


        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}