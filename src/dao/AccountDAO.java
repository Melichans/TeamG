package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.AccountBean;
import util.DBConnection;

public class AccountDAO {
    // BCrypt is removed. Login now checks plain text password.
    public AccountBean login(String username, String password) throws SQLException {
        AccountBean account = null;
        String sql = "SELECT account_id, username, password, role_id, created_at FROM account WHERE username = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password); // Plain text password comparison
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                account = new AccountBean();
                account.setAccountId(rs.getInt("account_id"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setRoleId(rs.getInt("role_id"));
                account.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            throw new SQLException("error: " + e.getMessage(), e);
        }
        return account;
    }

    public AccountBean getAccountById(int accountId) throws SQLException {
        AccountBean account = null;
        String sql = "SELECT account_id, username, password, role_id, created_at FROM account WHERE account_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                account = new AccountBean();
                account.setAccountId(rs.getInt("account_id"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setRoleId(rs.getInt("role_id"));
                account.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            throw new SQLException("Error getting account by ID: " + e.getMessage(), e);
        }
        return account;
    }

    // BCrypt is removed. Password is saved in plain text.
    public void updatePassword(int accountId, String newPassword) throws SQLException {
        String sql = "UPDATE account SET password = ? WHERE account_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newPassword); // Saving plain text password
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error updating password: " + e.getMessage(), e);
        }
    }
}
 