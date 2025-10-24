package shift;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ShiftBean;
import util.DBConnection;

@WebServlet("/shift/ShiftListExecuteAction")
public class ShiftListExecuteAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        List<ShiftBean> shiftList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT s.shift_id, s.user_id, s.dept_id, s.shift_date, "
                       + "s.start_time, s.end_time, s.status, u.user_name "
                       + "FROM shifts s "
                       + "JOIN users u ON s.user_id = u.user_id "
                       + "ORDER BY s.shift_date ASC, s.start_time ASC";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ShiftBean shift = new ShiftBean();
                shift.setShiftId(rs.getInt("shift_id"));
                shift.setUserId(rs.getInt("user_id"));
                shift.setDeptId(rs.getInt("dept_id"));
                shift.setShiftDate(rs.getDate("shift_date"));
                shift.setStartTime(rs.getTime("start_time"));
                shift.setEndTime(rs.getTime("end_time"));
                shift.setStatus(rs.getString("status"));
                shift.setUserName(rs.getString("user_name"));
                shiftList.add(shift);
            }

            rs.close();
            pstmt.close();

            // JSPにデータを渡す
            request.setAttribute("shiftList", shiftList);

            // ✅ 修正：ShiftList フォルダに直接ある JSP へフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher("/shiftlist/ListShift.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト一覧の取得中にエラーが発生しました：" + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/shiftlist/ListShift.jsp");
            dispatcher.forward(request, response);
        }
    }
}
