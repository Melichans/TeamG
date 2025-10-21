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

@WebServlet("/shift/addShiftAction")
public class AddShiftAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // セッションからユーザーを取得（ログイン済みと仮定）
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("loginAction");
            return;
        }

        try {
            ShiftBean shift = new ShiftBean();
            shift.setUserId(user.getUserId());
            shift.setDeptId(Integer.parseInt(request.getParameter("deptId"))); // フォームから取得
            shift.setShiftDate(java.sql.Date.valueOf(request.getParameter("shiftDate"))); // フォーマット: YYYY-MM-DD
            shift.setStartTime(java.sql.Time.valueOf(request.getParameter("startTime"))); // フォーマット: HH:MM:SS
            shift.setEndTime(java.sql.Time.valueOf(request.getParameter("endTime")));
            shift.setStatus("未提出");
            shift.setCreatedAt(new Timestamp(System.currentTimeMillis()));

            ShiftDAO shiftDAO = new ShiftDAO(DBConnection.getConnection());
            shiftDAO.addShift(shift);

            response.sendRedirect("user_home.jsp?message=シフト申請が成功しました。"); // メッセージ付きでリダイレクト
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト申請エラー: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("shift_request.jsp");
            rd.forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "入力形式が正しくありません。");
            RequestDispatcher rd = request.getRequestDispatcher("shift_request.jsp");
            rd.forward(request, response);
        }
    }
}