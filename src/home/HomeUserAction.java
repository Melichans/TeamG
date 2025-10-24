package home;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import util.DBConnection;

@WebServlet("/home/HomeUserAction")
public class HomeUserAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // シフト情報の取得はJavaScriptで動的に行われるため、ここでは不要
            // ShiftDAO shiftDAO = new ShiftDAO(conn);
            // List<ShiftBean> shiftList = shiftDAO.getShiftsByUser(user.getUserId());

            // request.setAttribute("shiftList", shiftList);
            request.getRequestDispatcher("/home/user_home.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト情報の取得に失敗しました。");
            request.getRequestDispatcher("/home/user_home.jsp").forward(request, response);
        }
    }
}
