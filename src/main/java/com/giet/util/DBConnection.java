package com.giet.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerceapp?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "Sidhu@129";

    // Prevent instantiation
    private DBConnection(){}

    public static Connection getConnection() throws SQLException {
        // For modern drivers (MySQL Connector/J 8+), explicit Class.forName not required.
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
