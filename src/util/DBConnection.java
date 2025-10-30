package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/shift_ai_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Tokyo&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            // MySQLドライバをロードします（Java 8以降はオプション、自動的にロードされます）
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driverが見つかりません： " + e.getMessage(), e);
        } catch (SQLException e) {
            throw new SQLException("MySQL接続エラー： " + e.getMessage(), e);
        }
    }
}