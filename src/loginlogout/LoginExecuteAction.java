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
    private AccountDAO accountDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        accountDAO = new AccountDAO();
        userDAO = new UserDAO(DBConnection.getConnection());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Set character encoding để hỗ trợ tiếng Nhật
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String companyCode = request.getParameter("companyCode");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // 1. Kiểm tra đăng nhập bằng AccountDAO (bao gồm username + password)
            AccountBean account = accountDAO.login(username, password);
            if (account != null) {
                // 2. Lấy thông tin người dùng với companyCode
                UserBean user = userDAO.getUserByCredentials(companyCode, username);
                if (user != null) {
                    // 3. Lấy role_name từ role_id
                    String roleName = getRoleName(account.getRoleId());
                    
                    // 4. Lưu vào session
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    session.setAttribute("user", user);
                    session.setAttribute("role", roleName);

                    // 5. Chuyển hướng dựa trên role
                    switch (roleName) {
                        case "ADMIN":
                            response.sendRedirect(request.getContextPath() + "/admin_home.jsp");
                            break;
                        case "USER":
                            response.sendRedirect(request.getContextPath() + "/user_home.jsp");
                            break;
                        default:
                            response.sendRedirect(request.getContextPath() + "/user_home.jsp");
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
            request.setAttribute("error", "システムエラーが発生しました。");
            RequestDispatcher rd = request.getRequestDispatcher("/loginlogout/login.jsp");
            rd.forward(request, response);
        }
    }

    private String getRoleName(int roleId) throws SQLException {
        String sql = "SELECT role_name FROM role WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role_name");
            }
            return "USER"; // Mặc định
        }
    }
}