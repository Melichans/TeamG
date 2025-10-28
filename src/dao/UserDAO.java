package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.UserBean;

public class UserDAO {
    private Connection conn;

    public UserDAO() throws SQLException {
        this.conn = util.DBConnection.getConnection();
    }

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public UserBean getUserByCredentials(String companyCode, String username) throws SQLException {
        UserBean user = null;
        String sql = "SELECT u.user_id, u.account_id, u.company_id, c.company_code, c.company_name, " +
                     "u.name, u.gender, u.position, u.phone, u.email, u.joined_date, " +
                     "u.push_notifications_enabled " +
                     "FROM user u " +
                     "JOIN account a ON u.account_id = a.account_id " +
                     "JOIN company c ON u.company_id = c.company_id " +
                     "WHERE c.company_code = ? AND a.username = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, companyCode);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setAccountId(rs.getInt("account_id"));
                user.setCompanyId(rs.getInt("company_id"));
                user.setCompanyCode(rs.getString("company_code"));
                user.setCompanyName(rs.getString("company_name"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getString("gender"));
                user.setPosition(rs.getString("position"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setJoinedDate(rs.getDate("joined_date"));
                user.setPushNotificationsEnabled(rs.getBoolean("push_notifications_enabled"));
            }
        } catch (SQLException e) {
            throw new SQLException("error: " + e.getMessage(), e);
        }
        return user;
    }

    public void updateUserSettings(int userId, boolean notificationsEnabled, String language) throws SQLException {
        String sql = "UPDATE user SET push_notifications_enabled = ?, language = ? WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, notificationsEnabled);
            ps.setString(2, language);
            ps.setInt(3, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Error updating user settings: " + e.getMessage(), e);
        }
    }

    public UserBean getUserByAccountId(int accountId) throws SQLException {
        UserBean user = null;
        String sql = "SELECT u.user_id, u.account_id, u.company_id, c.company_code, c.company_name, " +
                     "u.name, u.gender, u.position, u.phone, u.email, u.joined_date, " +
                     "u.push_notifications_enabled " +
                     "FROM user u " +
                     "JOIN account a ON u.account_id = a.account_id " +
                     "JOIN company c ON u.company_id = c.company_id " +
                     "WHERE u.account_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setAccountId(rs.getInt("account_id"));
                user.setCompanyId(rs.getInt("company_id"));
                user.setCompanyCode(rs.getString("company_code"));
                user.setCompanyName(rs.getString("company_name"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getString("gender"));
                user.setPosition(rs.getString("position"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setJoinedDate(rs.getDate("joined_date"));
                user.setPushNotificationsEnabled(rs.getBoolean("push_notifications_enabled"));
            }
        } catch (SQLException e) {
            throw new SQLException("error: " + e.getMessage(), e);
        }
        return user;
    }
}