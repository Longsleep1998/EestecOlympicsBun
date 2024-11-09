package com.example.catalog;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseCon {
    public static Connection initializeDatabase()
            throws SQLException, ClassNotFoundException
    {
        String dbDriver = "com.mysql.cj.jdbc.Driver";
        String dbURL = "jdbc:mysql://localhost:3306/";
        // Database name to access
        String dbName = "catalog";
        String dbUsername = "root";
        String dbPassword = "";

        Class.forName(dbDriver);
        Connection con = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
        return con;
    }
}
