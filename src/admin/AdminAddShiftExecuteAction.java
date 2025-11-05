package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Time;
import java.text.SimpleDateFormat;

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

@WebServlet("/admin/AdminAddShiftExecuteAction")
public class AdminAddShiftExecuteAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null || !("admin".equals(user.getRoleName()) || "developer".equals(user.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        try {
            request.setCharacterEncoding("UTF-8");
            int userId = Integer.parseInt(request.getParameter("userId"));
            int deptId = Integer.parseInt(request.getParameter("deptId"));
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(request.getParameter("shiftDate"));
            java.sql.Date shiftDate = new java.sql.Date(utilDate.getTime());

            // Time format is HH:mm, which can be parsed directly by Time.valueOf
            Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
            Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");

            ShiftBean newShift = new ShiftBean();
            newShift.setUserId(userId);
            newShift.setDeptId(deptId);
            newShift.setShiftDate(shiftDate);
            newShift.setStartTime(startTime);
            newShift.setEndTime(endTime);
            newShift.setMemo("管理者によって追加されました"); // Admin added memo

            try (Connection conn = DBConnection.getConnection()) {
                ShiftDAO shiftDAO = new ShiftDAO(conn);
                shiftDAO.addAdminInitiatedShift(newShift);
            }

            // Redirect to the shift list page to show the result
            response.sendRedirect(request.getContextPath() + "/admin/ListAllShiftsAction");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "シフトの追加中にエラーが発生しました。: " + e.getMessage());
            request.getRequestDispatcher("/not_implemented.jsp").forward(request, response);
        }
    }
}
