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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        List<ShiftBean> shiftList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql =
                "SELECT s.shift_id, s.user_id, s.dept_id, d.dept_name, " +
                "s.shift_date, s.start_time, s.end_time, s.status, u.name AS user_name " +
                "FROM shift s " +
                "LEFT JOIN user u ON s.user_id = u.user_id " +
                "LEFT JOIN department d ON s.dept_id = d.dept_id " +
                "ORDER BY s.shift_date ASC, s.start_time ASC";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            System.out.println("===== [DEBUG] ShiftListExecuteAction START =====");

            while (rs.next()) {
                ShiftBean shift = new ShiftBean();
                shift.setShiftId(rs.getInt("shift_id"));
                shift.setUserId(rs.getInt("user_id"));
                shift.setDeptId(rs.getInt("dept_id"));

                // ✅ Nếu dept_name null hoặc trống, set "未設定"
                String deptName = rs.getString("dept_name");
                if (deptName == null || deptName.trim().isEmpty()) {
                    deptName = "未設定";
                }
                shift.setDeptName(deptName);

                shift.setShiftDate(rs.getDate("shift_date"));
                shift.setStartTime(rs.getTime("start_time"));
                shift.setEndTime(rs.getTime("end_time"));
                shift.setStatus(rs.getString("status"));
                shift.setUserName(rs.getString("user_name"));

                shiftList.add(shift);

                // ✅ Log từng dòng dữ liệu
                System.out.println("[DEBUG] shift_id=" + shift.getShiftId()
                    + ", user_id=" + shift.getUserId()
                    + ", user_name=" + shift.getUserName()
                    + ", dept_id=" + shift.getDeptId()
                    + ", dept_name=" + shift.getDeptName()
                    + ", shift_date=" + shift.getShiftDate()
                    + ", start=" + shift.getStartTime()
                    + ", end=" + shift.getEndTime()
                    + ", status=" + shift.getStatus());
            }

            System.out.println("===== [DEBUG] ShiftListExecuteAction END (" + shiftList.size() + " rows) =====");

            rs.close();
            pstmt.close();

            // JSPへデータを渡す
            request.setAttribute("shiftList", shiftList);

            // Forward đến trang hiển thị lịch
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
