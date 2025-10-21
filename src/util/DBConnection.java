package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/shift_ai_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Tokyo&allowPublicKeyRetrieval=true&useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Mật khẩu MySQL của bạn

    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL driver (tùy chọn cho Java 8+, tự động load)
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver không tìm thấy: " + e.getMessage(), e);
        } catch (SQLException e) {
            throw new SQLException("Lỗi kết nối MySQL: " + e.getMessage(), e);
        }
    }
}