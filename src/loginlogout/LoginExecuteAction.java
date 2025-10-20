package loginlogout;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.AccountBean;
import bean.UserBean;
import dao.AccountDAO;
import dao.UserDAO;
import util.DBConnection;

@WebServlet("/loginlogout/loginExecute")
public class LoginExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String companyCode = request.getParameter("companyCode");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Kiểm tra đăng nhập bằng AccountDAO
            AccountDAO accountDAO = new AccountDAO();
            AccountBean account = accountDAO.login(username, password);
            if (account != null) {
                // Lấy thông tin người dùng
                UserDAO userDAO = new UserDAO(DBConnection.getConnection());
                UserBean user = userDAO.getUserByCredentials(companyCode, username);
                if (user != null) {
                    // Lấy role_name từ role_id
                    String roleName = getRoleName(account.getRoleId());

                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setAttribute("user", user);

                    // Chuyển hướng dựa trên role
                    switch (roleName.toLowerCase()) {
                        case "admin":
                            response.sendRedirect("admin_home.jsp");
                            break;
                        default:
                            response.sendRedirect("user_home.jsp");
                            break;
                    }
                } else {
                    request.setAttribute("error", "企業IDまたはユーザーIDが正しくありません。");
                    RequestDispatcher rd = request.getRequestDispatcher("/loginlogout/login.jsp");
                    rd.forward(request, response);
                }
            } else {
                request.setAttribute("error", "ユーザーIDまたはパスワードが正しくありません。");
                RequestDispatcher rd = request.getRequestDispatcher("/loginlogout/login.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    private String getRoleName(int roleId) throws SQLException {
        String roleName = "USER";
        String sql = "SELECT role_name FROM role WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                roleName = rs.getString("role_name");
            }
        }
        return roleName;
    }
}