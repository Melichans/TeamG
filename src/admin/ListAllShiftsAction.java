package admin;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ShiftBean;
import bean.UserBean;
import dao.ShiftDAO;
import dao.UserDAO;
import util.DBConnection;

@WebServlet("/admin/ListAllShiftsAction")
public class ListAllShiftsAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Fetch list of all users for the filter dropdown
            UserDAO userDAO = new UserDAO(conn);
            List<UserBean> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);

            // Get selected user ID from request
            String selectedUserIdStr = request.getParameter("selectedUserId");
            Integer selectedUserId = null;
            if (selectedUserIdStr != null && !selectedUserIdStr.isEmpty() && !"all".equals(selectedUserIdStr)) {
                try {
                    selectedUserId = Integer.parseInt(selectedUserIdStr);
                } catch (NumberFormatException e) {
                    // Handle invalid ID, maybe log it or show an error
                }
            }

            ShiftDAO shiftDAO = new ShiftDAO(conn);
            List<ShiftBean> shiftList = shiftDAO.getAllManageableShifts(selectedUserId);

            request.setAttribute("shiftList", shiftList);
            request.setAttribute("selectedUserId", selectedUserId);
            request.getRequestDispatcher("/admin/shift_correction.jsp").forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "シフトの読み込み中にエラーが発生しました。: " + e.getMessage());
            request.getRequestDispatcher("/admin/shift_correction.jsp").forward(request, response);

        }
    }
}