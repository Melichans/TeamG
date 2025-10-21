package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.AccountBean;
import util.DBConnection;

public class AccountDAO {
    public AccountBean login(String username, String password) throws SQLException {
        AccountBean account = null;
        String sql = "SELECT account_id, username, password, role_id, created_at " +
                     "FROM account WHERE username = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password); 
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
}