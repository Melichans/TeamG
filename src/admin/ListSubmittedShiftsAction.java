package admin;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ShiftBean;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/admin/ListSubmittedShiftsAction")
public class ListSubmittedShiftsAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String forward_path = "/admin/submitted_shifts.jsp";

        try (Connection conn = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);
            // 「提出済み」のステータスを持つシフトを取得
            List<ShiftBean> submittedShifts = shiftDAO.getShiftsByStatus("提出済み");
            request.setAttribute("submittedShifts", submittedShifts);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "シフト申請リストの取得中にエラーが発生しました: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(forward_path);
        dispatcher.forward(request, response);
    }
}
