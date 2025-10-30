package shift;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/shift/SubmitPeriodAction")
public class SubmitPeriodAction extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        // 1. Check user login
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        int userId = currentUser.getUserId();

        // 2. Get period dates from the form
        String startDateStr = request.getParameter("periodStartDate");
        String endDateStr = request.getParameter("periodEndDate");

        if (startDateStr == null || endDateStr == null || startDateStr.isEmpty() || endDateStr.isEmpty()) {
            // Handle error: redirect back with an error message
            session.setAttribute("globalError", "期間の指定が不正です。もう一度やり直してください。");
            response.sendRedirect(request.getContextPath() + "/home/user_home.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);

            // 3. Call the new DAO method to handle the submission logic
            // This method will perform the delete and update operations.
            shiftDAO.submitDraftsForPeriod(userId, startDate, endDate);

            // 4. Set success message and redirect
            session.setAttribute("globalMessage", "シフトを提出しました。");
            response.sendRedirect(request.getContextPath() + "/home/user_home.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // Handle error: redirect back with an error message
            session.setAttribute("globalError", "シフトの提出中にエラーが発生しました: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/home/user_home.jsp");
        }
    }
}
