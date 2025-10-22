package shift;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ShiftBean;
import bean.UserBean;
import dao.ShiftDAO;　
import util.DBConnection;

@WebServlet("/shift/addShiftExecuteAction")
public class AddShiftExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("../login.jsp");
            return;
        }

        try {
            int deptId = Integer.parseInt(request.getParameter("deptId"));
            String shiftDateStr = request.getParameter("shiftDate");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            if (shiftDateStr == null || startTimeStr == null || endTimeStr == null ||
                shiftDateStr.isEmpty() || startTimeStr.isEmpty() || endTimeStr.isEmpty()) {
                request.setAttribute("error", "全ての項目を入力してください。");
                RequestDispatcher rd = request.getRequestDispatcher("/shift/shift_request.jsp");
                rd.forward(request, response);
                return;
            }

            ShiftBean shift = new ShiftBean();
            shift.setUserId(user.getUserId());
            shift.setDeptId(deptId);
            shift.setShiftDate(java.sql.Date.valueOf(shiftDateStr));
            shift.setStartTime(java.sql.Time.valueOf(startTimeStr + ":00"));
            shift.setEndTime(java.sql.Time.valueOf(endTimeStr + ":00"));
            shift.setStatus("未提出");
            shift.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            ShiftDAO shiftDAO = new ShiftDAO(DBConnection.getConnection());
            shiftDAO.addShift(shift);

            response.sendRedirect("list?message=シフト登録が完了しました。");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト登録中にエラーが発生しました：" + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/shift/shift_request.jsp");
            rd.forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "日付または時刻の形式が正しくありません。");
            RequestDispatcher rd = request.getRequestDispatcher("/shift/shift_request.jsp");
            rd.forward(request, response);
        }
    }
}
