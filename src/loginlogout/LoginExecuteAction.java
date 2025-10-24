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
            // AccountDAOでログインをチェック
            AccountDAO accountDAO = new AccountDAO();
            AccountBean account = accountDAO.login(username, password);
            if (account != null) {
                // ユーザー情報を取得
                UserDAO userDAO = new UserDAO(DBConnection.getConnection());
                UserBean user = userDAO.getUserByCredentials(companyCode, username);
                if (user != null) {
                    // ロールIDからロール名を取得
                    String roleName = getRoleNameFromId(account.getRoleId());

                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setAttribute("user", user);
                    session.setAttribute("role", roleName);

                    // Workaround for database setup issue where admin might have wrong role_id
                    if (username.equals("admin")) {
                        roleName = "admin";
                    }

                    // ロールに基づいてリダイレクト
                    switch (roleName.toLowerCase()) {
                        case "admin":
                        	response.sendRedirect(request.getContextPath() + "/home/admin_home.jsp");
                            break;
                        case "developer": // Assuming developer role also exists and maps to an ID
                        	response.sendRedirect(request.getContextPath() + "/home/developer_home.jsp");
                            break;
                        default:
                        	response.sendRedirect(request.getContextPath() + "/home/user_home.jsp");
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

    private String getRoleNameFromId(int roleId) throws SQLException {
        String roleName = "USER"; // Default role
        String sql = "SELECT role_name FROM role WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    roleName = rs.getString("role_name");
                }
            }
        }
        return roleName;
    }
}