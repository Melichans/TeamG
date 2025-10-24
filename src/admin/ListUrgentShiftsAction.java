package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ShiftBean;
import bean.UserBean;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/admin/ListUrgentShiftsAction")
public class ListUrgentShiftsAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        // Only admin can view/manage urgent shifts
        if (!"ADMIN".equals(currentUser.getPosition())) { // Assuming 'position' field indicates role for simplicity
            response.sendRedirect(request.getContextPath() + "/home/user_home.jsp"); // Redirect non-admins
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);
            List<ShiftBean> urgentShifts = shiftDAO.getOpenShifts();
            request.setAttribute("urgentShifts", urgentShifts);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/list_urgent_shifts.jsp");
            rd.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "緊急シフトのリスト取得中にエラーが発生しました: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_home.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
