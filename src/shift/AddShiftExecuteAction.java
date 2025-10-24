package shift;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.DBConnection;

@WebServlet("/shift/AddShiftExecuteAction")
public class AddShiftExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // フォームから取得
        int userId = Integer.parseInt(request.getParameter("userId"));
        String shiftDate = request.getParameter("shiftDate");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO shifts (user_id, shift_date, start_time, end_time, status) "
                       + "VALUES (?, ?, ?, ?, '申請中')";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, shiftDate);
            pstmt.setString(3, startTime);
            pstmt.setString(4, endTime);

            pstmt.executeUpdate();
            pstmt.close();

            // 完了後は再び Add.jsp に戻る
            request.setAttribute("message", "登録が完了しました！");
            RequestDispatcher dispatcher =
                    request.getRequestDispatcher("/AddShift/Add.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "登録時にエラー発生：" + e.getMessage());
            RequestDispatcher dispatcher =
                    request.getRequestDispatcher("/AddShift/Add.jsp");
            dispatcher.forward(request, response);
        }
    }
}
