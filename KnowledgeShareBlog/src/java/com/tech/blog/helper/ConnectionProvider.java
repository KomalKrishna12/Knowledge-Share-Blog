package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null) {
                // load driver class
                Class.forName("com.mysql.cj.jdbc.Driver");

                // create a connection
                String url = "jdbc:mysql://localhost:3306/techblog";
                con = DriverManager.getConnection(url, "root", "1234");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
