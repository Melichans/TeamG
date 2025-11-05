package shift;

import java.io.IOException;
import java.sql.Connection;
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

@WebServlet("/shift/ListForConfirmationAction")
public class ListForConfirmationAction extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        int userId = currentUser.getUserId();
        String forwardPath = "/shift/shift_confirmation_list.jsp";

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);
            
            // Create a list of statuses to fetch
            List<String> statusesToFetch = new java.util.ArrayList<>();
            statusesToFetch.add("承認済み");
            statusesToFetch.add("修正依頼");

            // Get shifts with 'Approved' or 'Modification Request' status for the current user
            List<ShiftBean> confirmationList = shiftDAO.getShiftsByStatusForUser(userId, statusesToFetch);
            
            request.setAttribute("confirmationList", confirmationList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "確認待ちシフトのリスト取得中にエラーが発生しました: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(forwardPath);
        dispatcher.forward(request, response);
    }
}
