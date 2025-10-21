package user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnection;

public class UserListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        java.util.List<bean.UserBean> userList = new java.util.ArrayList<>();
        String sql = "SELECT u.user_id, u.name, u.gender, u.position, u.phone, u.email, u.joined_date, a.username, r.role_name " +
                     "FROM user u " +
                     "JOIN account a ON u.account_id = a.account_id " +
                     "JOIN role r ON a.role_id = r.role_id";

        try (Connection con = util.DBConnection.getConnection();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {

            java.sql.ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bean.UserBean user = new bean.UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getString("gender"));
                user.setPosition(rs.getString("position"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setJoinedDate(rs.getDate("joined_date"));
                user.setUsername(rs.getString("username"));
                user.setRoleName(rs.getString("role_name"));
                userList.add(user);
            }

            request.setAttribute("users", userList);
            javax.servlet.RequestDispatcher dispatcher = request.getRequestDispatcher("users.jsp");
            dispatcher.forward(request, response);

        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            response.getWriter().println("❌ Database error: " + e.getMessage());
        }
    }
}
