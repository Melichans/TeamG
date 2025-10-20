import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ShiftBean;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/addShift")
public class AddShiftAction extends HttpServlet {
    private ShiftDAO shiftDAO;

    @Override
    public void init() throws ServletException {
        shiftDAO = new ShiftDAO(DBConnection.getConnection());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ShiftBean shift = new ShiftBean();
            shift.setUserId(Integer.parseInt(request.getParameter("userId")));
            shift.setDeptId(Integer.parseInt(request.getParameter("deptId")));
            shift.setShiftDate(java.sql.Date.valueOf(request.getParameter("shiftDate")));
            shift.setStartTime(java.sql.Time.valueOf(request.getParameter("startTime")));
            shift.setEndTime(java.sql.Time.valueOf(request.getParameter("endTime")));
            shift.setStatus("未提出");
            shift.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            shiftDAO.addShift(shift);
            response.sendRedirect("shift_list.jsp");
        } catch (SQLException e) {
            throw new ServletException("Lỗi thêm ca", e);
        }
    }
}