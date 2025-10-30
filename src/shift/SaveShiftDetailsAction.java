package shift;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Time;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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

@WebServlet("/shift/SaveShiftDetailsAction")
public class SaveShiftDetailsAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");
        int userId = currentUser.getUserId();

        String rawDateStr = request.getParameter("rawDate");
        String deptIdStr = request.getParameter("deptId");
        String workPreference = request.getParameter("work_preference"); // "work" or "rest"
        String startTimeHourStr = request.getParameter("startTimeHour");
        String startTimeMinuteStr = request.getParameter("startTimeMinute");
        String endTimeHourStr = request.getParameter("endTimeHour");
        String endTimeMinuteStr = request.getParameter("endTimeMinute");
        String memo = request.getParameter("memo");

        String periodStartDateStr = request.getParameter("periodStartDate");
        String periodEndDateStr = request.getParameter("periodEndDate");

        // Ensure parameters are not null to prevent issues in the redirect URL
        if (periodStartDateStr == null) periodStartDateStr = "";
        if (periodEndDateStr == null) periodEndDateStr = "";

        String redirectUrl = request.getContextPath() + "/shift/EnterShiftsAction?startDate=" + periodStartDateStr + "&endDate=" + periodEndDateStr;

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);

            LocalDate shiftLocalDate = LocalDate.parse(rawDateStr);
            java.sql.Date shiftSqlDate = java.sql.Date.valueOf(shiftLocalDate);

            if ("rest".equals(workPreference)) {
                // If preference is 'rest', delete any existing shift for this user and date
                shiftDAO.deleteUserShift(userId, shiftSqlDate);
                request.setAttribute("message", shiftLocalDate.format(DateTimeFormatter.ofPattern("M/d")) + "のシフトを削除しました。");
            } else { // Preference is 'work'
                int deptId = Integer.parseInt(deptIdStr);
                Time startTime = Time.valueOf(startTimeHourStr + ":" + startTimeMinuteStr + ":00");
                Time endTime = Time.valueOf(endTimeHourStr + ":" + endTimeMinuteStr + ":00");

                ShiftBean shift = new ShiftBean();
                shift.setUserId(userId);
                shift.setShiftDate(shiftSqlDate);
                shift.setDeptId(deptId);
                shift.setStartTime(startTime);
                shift.setEndTime(endTime);
                shift.setStatus("下書き"); // Save as draft
                shift.setMemo(memo); // Assuming ShiftBean has a memo field

                shiftDAO.saveOrUpdateUserShift(shift);
                request.setAttribute("message", shiftLocalDate.format(DateTimeFormatter.ofPattern("M/d")) + "のシフトを保存しました。");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "シフトの保存中にエラーが発生しました: " + e.getMessage());
        }

        // Redirect back to the list of days
        response.sendRedirect(redirectUrl);
    }
}
