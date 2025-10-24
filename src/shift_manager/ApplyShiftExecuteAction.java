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
        int shiftIdToApply = Integer.parseInt(request.getParameter("shiftId"));

        try (Connection con = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(con);
            // This method needs to be implemented in ShiftDAO
            // shiftDAO.applyForShift(shiftIdToApply, currentUser.getUserId());
            
            // For now, just redirect with a success message
            int updatedRows = shiftDAO.applyForShift(shiftIdToApply, currentUser.getUserId());
            if (updatedRows > 0) {
                response.sendRedirect(request.getContextPath() + "/shift_manager/OpenShiftsAction?message=シフトの登録が成功しました！");
            } else {
                request.setAttribute("error", "シフトの登録に失敗しました。既に他のユーザーが登録したか、シフトが見つかりません。");
                RequestDispatcher rd = request.getRequestDispatcher("/shift_manager/open_shifts.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト登録中にエラーが発生しました： " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/shift_manager/open_shifts.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID ca làm việc không hợp lệ.");
            RequestDispatcher rd = request.getRequestDispatcher("/shift_manager/open_shifts.jsp");
            rd.forward(request, response);
        }
    }
}