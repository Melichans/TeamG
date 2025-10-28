package shift;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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

@WebServlet("/shift/EnterShiftsAction")
public class EnterShiftsAction extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
                return;
            }

            UserBean user = (UserBean) session.getAttribute("user");
            int userId = user.getUserId();

            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);

            // DBからこの期間のシフト取得
            List<ShiftBean> existingShifts;
            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO dao = new ShiftDAO(conn);
                existingShifts = dao.getShiftsForUserBetweenDates(userId, startDate, endDate);
            }

            // マップ化: 日付文字列 -> ShiftBean
            Map<String, ShiftBean> shiftMap = new HashMap<>();
            DateTimeFormatter dateKeyFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            for (ShiftBean s : existingShifts) {
                shiftMap.put(s.getShiftDate().toLocalDate().format(dateKeyFmt), s);
            }

            // 日付リストを生成
            List<Map<String, Object>> dayList = new ArrayList<>();
            LocalDate current = startDate;
            DateTimeFormatter displayFmt = DateTimeFormatter.ofPattern("M/d(E)", Locale.JAPANESE);

            while (!current.isAfter(endDate)) {
                Map<String, Object> day = new HashMap<>();
                String key = current.format(dateKeyFmt);
                day.put("date", key);
                day.put("label", current.format(displayFmt));
                day.put("shift", shiftMap.get(key)); // Pass the whole ShiftBean or null
                dayList.add(day);
                current = current.plusDays(1);
            }

            // ✅ debug ngay sau khi danh sách được tạo xong
            System.out.println("[DEBUG EnterShiftsAction] startDateStr=" + startDateStr);
            System.out.println("[DEBUG EnterShiftsAction] endDateStr=" + endDateStr);
            System.out.println("[DEBUG EnterShiftsAction] dayList size=" + dayList.size());
            if (!dayList.isEmpty()) {
                System.out.println("[DEBUG EnterShiftsAction] first day = " + dayList.get(0).get("date"));
                System.out.println("[DEBUG EnterShiftsAction] last day = " + dayList.get(dayList.size() - 1).get("date"));
            }

            // rồi sau đó mới set attribute
            request.setAttribute("dayList", dayList);
            request.setAttribute("periodStartDate", startDateStr);
            request.setAttribute("periodEndDate", endDateStr);


        } catch (Exception e) {
            e.printStackTrace();
            // Pass the detailed error message to the JSP for debugging
            String detailedError = "エラー発生: " + e.toString();
            request.setAttribute("detailedError", detailedError);
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/addshift/enter_shifts.jsp");
        dispatcher.forward(request, response);
    }
}
