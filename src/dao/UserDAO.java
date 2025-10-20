
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.UserBean;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public UserBean login(String companyCode, String username, String password) throws SQLException {
    	String sql = "SELECT * FROM account a "
    	           + "JOIN user u ON a.id = u.account_id "
    	           + "WHERE a.company_name = ? AND a.login_id = ? AND a.password = ?";


        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, companyCode);
            ps.setString(2, username);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserBean user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setCompanyId(rs.getInt("company_id"));
                user.setCompanyCode(rs.getString("company_code"));
                user.setCompanyName(rs.getString("company_name"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setPosition(rs.getString("position"));
                user.setRole(rs.getString("role"));
                return user;
            }
        }
        return null;
    }
}
