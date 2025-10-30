package shift;

import java.io.IOException;
import java.sql.Connection;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/shift/ConfirmShiftsAction")
public class ConfirmShiftsAction extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        // 1. Get the array of selected shift IDs from the form
        String[] shiftIdsStr = request.getParameterValues("shiftIds");

        if (shiftIdsStr == null || shiftIdsStr.length == 0) {
            // No shifts were selected, redirect back with a message
            session.setAttribute("confirmationError", "確認するシフトが選択されていません。");
            response.sendRedirect(request.getContextPath() + "/shift/ListForConfirmationAction");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);

            // 2. Call a new DAO method to update all selected shifts
            shiftDAO.updateStatusForMultipleShifts(shiftIdsStr, "確認済み");

            // 3. Set success message and redirect
            session.setAttribute("confirmationSuccess", "選択したシフトを確定しました。");
            response.sendRedirect(request.getContextPath() + "/shift/ListForConfirmationAction");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("confirmationError", "シフトの確定中にエラーが発生しました: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/shift/ListForConfirmationAction");
        }
    }
}
