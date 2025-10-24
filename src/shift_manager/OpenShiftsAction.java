package shift_manager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
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

@WebServlet("/shift_manager/OpenShiftsAction")
public class OpenShiftsAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        UserBean currentUser = (UserBean) session.getAttribute("user");

        try (Connection con = DBConnection.getConnection()) {
            ShiftDAO shiftDAO = new ShiftDAO(con);
            // For now, let's assume open shifts are those with status '募集中' (recruiting)
            // This will require a new method in ShiftDAO to fetch open shifts
            // For demonstration, we'll just fetch all shifts for now and filter in JSP or add a new DAO method later.
            // List<ShiftBean> openShifts = shiftDAO.getOpenShifts(); // This method needs to be implemented
            
            // Placeholder: Fetch all shifts for now, or implement getOpenShifts in ShiftDAO
            // For now, let's just pass an empty list or a dummy list
            List<ShiftBean> openShifts = shiftDAO.getOpenShifts(); // Replace with actual data fetching

            request.setAttribute("openShifts", openShifts);
            RequestDispatcher rd = request.getRequestDispatcher("/shift_manager/open_shifts.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "募集中シフトのリスト読み込み中にエラーが発生しました： " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/shift_manager/open_shifts.jsp");
            rd.forward(request, response);
        }
    }
}