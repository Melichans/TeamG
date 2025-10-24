package password_change;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// BCrypt import is removed
import bean.AccountBean;
import bean.UserBean;
import dao.AccountDAO;

@WebServlet("/password/passwordChange")
public class PasswordChangeAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/login.jsp");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || newPassword.isEmpty() || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "新しいパスワードが一致しないか、空です。");
            doGet(request, response);
            return;
        }

        try {
            AccountDAO accountDAO = new AccountDAO();
            AccountBean account = accountDAO.getAccountById(user.getAccountId());

            // BCrypt.checkpw is replaced with simple string .equals()
            if (account != null && account.getPassword().equals(currentPassword)) {
                accountDAO.updatePassword(user.getAccountId(), newPassword);
                request.setAttribute("success", "パスワードが正常に変更されました。");
            } else {
                request.setAttribute("error", "現在のパスワードが正しくありません。");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "データベースエラーが発生しました。");
        }
        
        doGet(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/login.jsp");
            return;
        }

        try {
            AccountDAO accountDAO = new AccountDAO();
            AccountBean account = accountDAO.getAccountById(user.getAccountId());
            request.setAttribute("account", account);
            // The user bean is already in the session, but setting it again for consistency
            request.setAttribute("user", user); 
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "ユーザー情報の取得中にエラーが発生しました。");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/password/password_change.jsp");
        dispatcher.forward(request, response);
    }
}
