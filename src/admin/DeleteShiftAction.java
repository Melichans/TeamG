package admin;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.ShiftDAO;
import util.DBConnection;

@WebServlet("/admin/DeleteShiftAction")
public class DeleteShiftAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null || !("admin".equals(user.getRoleName()) || "developer".equals(user.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        try {
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));

            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(conn);
                shiftDAO.deleteShiftById(shiftId);
            } 

            // Redirect back to the list to show the result
            response.sendRedirect(request.getContextPath() + "/admin/ListAllShiftsAction");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            // Handle error - maybe redirect to an error page
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "無効なシフトIDです。");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle other exceptions
            request.setAttribute("errorMessage", "シフトの削除中にエラーが発生しました。: " + e.getMessage());
            request.getRequestDispatcher("/not_implemented.jsp").forward(request, response);
        }
    }
}
