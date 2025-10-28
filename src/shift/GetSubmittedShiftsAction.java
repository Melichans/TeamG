package shift;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import bean.ShiftBean;
import bean.UserBean;
import dao.ShiftDAO;

@WebServlet("/shift/getSubmittedShifts")
public class GetSubmittedShiftsAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        UserBean user = (UserBean) session.getAttribute("user");
        String yearStr = request.getParameter("year");
        String monthStr = request.getParameter("month");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try (Connection conn = util.DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(conn);
            int year = Integer.parseInt(yearStr);
            // In Java's Calendar/Date, month is 0-indexed, so we get it as is from JS.
            int month = Integer.parseInt(monthStr) + 1; 

            // We need a new DAO method to get shifts by status for a specific user and month
            List<ShiftBean> shifts = shiftDAO.getShiftsByMonthAndStatus(user.getUserId(), year, month, "提出済み");
            
            out.print(gson.toJson(shifts));

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(gson.toJson(new Error(e.getMessage())));
        }
        out.flush();
    }
}
