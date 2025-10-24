package admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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

@WebServlet("/admin/addUrgentShiftExecute")
public class AddUrgentShiftAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        // Only admin can add urgent shifts
        if (!"ADMIN".equals(currentUser.getPosition())) { // Assuming 'position' field indicates role for simplicity
            request.setAttribute("error", "管理者のみが緊急シフトを追加できます。");
            request.getRequestDispatcher("/admin/admin_home.jsp").forward(request, response);
            return;
        }

        String shiftDateStr = request.getParameter("shiftDate");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String deptIdStr = request.getParameter("deptId");

        if (shiftDateStr == null || shiftDateStr.isEmpty() ||
            startTimeStr == null || startTimeStr.isEmpty() ||
            endTimeStr == null || endTimeStr.isEmpty() ||
            deptIdStr == null || deptIdStr.isEmpty()) {
            request.setAttribute("error", "全ての項目を入力してください。");
            request.getRequestDispatcher("/admin/add_urgent_shift.jsp").forward(request, response);
            return;
        }

        try {
            Date shiftDate = Date.valueOf(shiftDateStr);
            Time startTime = Time.valueOf(startTimeStr + ":00"); // Assuming input is HH:MM
            Time endTime = Time.valueOf(endTimeStr + ":00");     // Assuming input is HH:MM
            int deptId = Integer.parseInt(deptIdStr);

            ShiftBean shift = new ShiftBean();
            shift.setShiftDate(shiftDate);
            shift.setStartTime(startTime);
            shift.setEndTime(endTime);
            shift.setDeptId(deptId);
            shift.setStatus("募集"); // Set status to '募集' for urgent shifts

            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(conn);
                shiftDAO.addShift(shift);
                request.setAttribute("success", "緊急シフトが正常に追加されました。");
                request.getRequestDispatcher("/admin/add_urgent_shift.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "緊急シフトの追加中にエラーが発生しました: " + e.getMessage());
                request.getRequestDispatcher("/admin/add_urgent_shift.jsp").forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "日付または時間の形式が不正です。");
            request.getRequestDispatcher("/admin/add_urgent_shift.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "部署IDの形式が不正です。");
            request.getRequestDispatcher("/admin/add_urgent_shift.jsp").forward(request, response);
        }
    }
}
