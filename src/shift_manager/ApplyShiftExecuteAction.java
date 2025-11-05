package shift_manager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.ShiftDAO;
import util.DBConnection;

import java.net.URLEncoder;

@WebServlet("/shift_manager/ApplyShiftExecuteAction")
public class ApplyShiftExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        String redirectURL = request.getContextPath() + "/shift_manager/OpenShiftsAction";

        try {
            int shiftIdToApply = Integer.parseInt(request.getParameter("shiftId"));

            try (Connection con = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(con);
                int updatedRows = shiftDAO.applyForShift(shiftIdToApply, currentUser.getUserId());

                if (updatedRows > 0) {
                    redirectURL += "?message=" + URLEncoder.encode("シフトの登録が成功しました！", "UTF-8");
                } else {
                    redirectURL += "?error=" + URLEncoder.encode("シフトの登録に失敗しました。既に他のユーザーが登録したか、シフトが見つかりません。", "UTF-8");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            redirectURL += "?error=" + URLEncoder.encode("データベースエラーが発生しました。", "UTF-8");
        } catch (NumberFormatException e) {
            redirectURL += "?error=" + URLEncoder.encode("ID ca làm việc không hợp lệ.", "UTF-8");
        }
        
        response.sendRedirect(redirectURL);
    }
}