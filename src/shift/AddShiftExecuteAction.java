package shift;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.DepartmentBean;
import bean.ShiftBean;
import dao.DepartmentDAO;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/shift/AddShiftExecuteAction")
public class AddShiftExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String forward_path = "/addshift/addshift.jsp";

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String shiftDateStr = request.getParameter("shiftDate");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            int deptId = Integer.parseInt(request.getParameter("deptId"));

            // --- Validation (simple) ---
            if (shiftDateStr.isEmpty() || startTimeStr.isEmpty() || endTimeStr.isEmpty()) {
                throw new Exception("日付と時間を入力してください。");
            }

            SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");

            ShiftBean shift = new ShiftBean();
            shift.setUserId(userId);
            java.util.Date utilDate = sdfDate.parse(shiftDateStr);
            shift.setShiftDate(new java.sql.Date(utilDate.getTime()));
            shift.setStartTime(new Time(sdfTime.parse(startTimeStr).getTime()));
            shift.setEndTime(new Time(sdfTime.parse(endTimeStr).getTime()));
            shift.setDeptId(deptId);
            // Status is set to '提出済み' inside DAO

            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(conn);
                shiftDAO.addUserShift(shift);
            }

            request.setAttribute("message", "シフトの登録が完了しました。");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "登録時にエラーが発生しました: " + e.getMessage());
        }
        
        // 部署リストを再取得してフォームを再表示
        try (Connection conn = DBConnection.getConnection()) {
            DepartmentDAO deptDAO = new DepartmentDAO(conn);
            List<DepartmentBean> departments = deptDAO.getAllDepartments();
            request.setAttribute("departments", departments);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "部署リストの取得中にエラーが発生しました。");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(forward_path);
        dispatcher.forward(request, response);
    }
}