package dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.UserBean;
import util.DBConnection;
 
public class UserDAO {
 
    public List<UserBean> getAllUsers() {
        List<UserBean> users = new ArrayList<>();
        String sql = "SELECT * FROM user";
 
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
 
            while (rs.next()) {
                UserBean user = new UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getString("gender"));
                user.setPosition(rs.getString("position"));
                user.setWorkplace(rs.getString("workplace"));
                users.add(user);
            }
 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
 
    public UserBean getUserById(int id) {
        UserBean user = null;
        String sql = "SELECT * FROM user WHERE user_id = ?";
 
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
 
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
 
            if (rs.next()) {
                user = new UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getString("gender"));
                user.setPosition(rs.getString("position"));
                user.setWorkplace(rs.getString("workplace"));
            }
 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}