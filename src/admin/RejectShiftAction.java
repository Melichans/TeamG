package admin;

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
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/admin/RejectShiftAction")
public class RejectShiftAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        // Basic admin check
        if (!("admin".equals(currentUser.getRoleName()) || "developer".equals(currentUser.getRoleName()))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "管理者権限が必要です。");
            return;
        }

        String shiftIdStr = request.getParameter("shiftId");
        if (shiftIdStr == null || shiftIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "シフトIDが指定されていません。");
            return;
        }

        try {
            int shiftId = Integer.parseInt(shiftIdStr);
            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(conn);
                shiftDAO.updateShiftStatus(shiftId, "拒否");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無効なシフトIDです。");
            e.printStackTrace();
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "シフト拒否中にデータベースエラーが発生しました。");
            e.printStackTrace();
        }

        // Redirect back to the submitted shifts list
        response.sendRedirect(request.getContextPath() + "/admin/ListSubmittedShiftsAction");
    }
}
