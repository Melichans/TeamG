package mypage;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.UserDAO;

@WebServlet("/mypage/updateSettings")
public class UpdateSettingsAction extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/css/login.jsp");
            return;
        }

        // Get parameters from the form
        String language = request.getParameter("language");
        // Checkbox value is "on" if checked, null if not.
        boolean notificationsEnabled = "on".equals(request.getParameter("push_notifications_enabled"));

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.updateUserSettings(user.getUserId(), notificationsEnabled, language);
            
            // Set a success message in the session
            session.setAttribute("successMessage", "設定を更新しました。");

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "設定の更新中にエラーが発生しました。");
        }

        // Redirect back to the My Page to show the updated settings and clear old request attributes
        response.sendRedirect(request.getContextPath() + "/mypage/myPage");
    }
}
