package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import bean.AccountBean;
import util.DBConnection;

public class AccountDAO {
    public AccountBean login(String username, String password) throws SQLException {
        AccountBean account = null;
        String sql = "SELECT account_id, username, password, role_id, created_at FROM account WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    account = new AccountBean();
                    account.setAccountId(rs.getInt("account_id"));
                    account.setUsername(rs.getString("username"));
                    account.setPassword(hashedPassword);
                    account.setRoleId(rs.getInt("role_id"));
                    account.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi đăng nhập: " + e.getMessage(), e);
        }
        return account;
    }

    public void addAccount(AccountBean account) throws SQLException {
        String sql = "INSERT INTO account (username, password, role_id, created_at) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String hashedPassword = BCrypt.hashpw(account.getPassword(), BCrypt.gensalt());
            ps.setString(1, account.getUsername());
            ps.setString(2, hashedPassword);
            ps.setInt(3, account.getRoleId());
            ps.setTimestamp(4, account.getCreatedAt());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Lỗi thêm tài khoản: " + e.getMessage(), e);
        }
    }
}