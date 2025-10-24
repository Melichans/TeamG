package mypage;

import java.io.IOException;
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

@WebServlet("/mypage/myPage")
public class MyPageAction extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            // If user is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/loginlogout/css/login.jsp");
            return;
        }

        try {
            // Get user's account information
            AccountDAO accountDAO = new AccountDAO();
            AccountBean account = accountDAO.getAccountById(user.getAccountId());
            
            // Also get full user details from DB to ensure settings are up-to-date
            UserDAO userDAO = new UserDAO(); // Use default constructor to get connection
            UserBean fullUser = userDAO.getUserByAccountId(user.getAccountId()); // Assuming a new method to get user by account ID

            if (fullUser != null) {
                session.setAttribute("user", fullUser); // Update session with full user details
                request.setAttribute("user", fullUser); // Set for JSP
            } else {
                // If fullUser is null, it means the user's account ID from session is invalid or user data is missing.
                // Invalidate session and redirect to login or an error page.
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/loginlogout/css/login.jsp?error=invalidUserSession");
                return;
            }
            request.setAttribute("account", account);

        } catch (SQLException e) {
            e.printStackTrace();
            // Set an error message if data retrieval fails
            request.setAttribute("error", "ユーザー情報の取得中にエラーが発生しました。");
            // Redirect to an error page or show error on current page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/mypage/my_page.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Forward to the My Page JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/mypage/my_page.jsp");
        dispatcher.forward(request, response);
    }
}
