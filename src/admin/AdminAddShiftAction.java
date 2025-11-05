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

import bean.DepartmentBean;
import bean.UserBean;
import dao.DepartmentDAO;
import dao.UserDAO;
import util.DBConnection;

@WebServlet("/admin/AdminAddShiftAction")
public class AdminAddShiftAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null || !("admin".equals(user.getRoleName()) || "developer".equals(user.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(conn);
            List<UserBean> userList = userDAO.getAllUsers();

            DepartmentDAO deptDAO = new DepartmentDAO(conn);
            List<DepartmentBean> departmentList = deptDAO.getAllDepartments();

            request.setAttribute("userList", userList);
            request.setAttribute("departmentList", departmentList);
            request.getRequestDispatcher("admin_add_shift.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "データの読み込み中にエラーが発生しました。: " + e.getMessage());
            request.getRequestDispatcher("/not_implemented.jsp").forward(request, response);
        }
    }
}
