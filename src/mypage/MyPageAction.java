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
            
            // Set user and account beans as request attributes
            request.setAttribute("user", user);
            request.setAttribute("account", account);

        } catch (SQLException e) {
            e.printStackTrace();
            // Set an error message if data retrieval fails
            request.setAttribute("error", "ユーザー情報の取得中にエラーが発生しました。");
        }

        // Forward to the My Page JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/mypage/my_page.jsp");
        dispatcher.forward(request, response);
    }
}
