package loginlogout;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.UserDAO;

@WebServlet("/loginlogout/loginExecute")
public class LoginExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String companyCode = request.getParameter("company_id");
        String username = request.getParameter("user_id");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ai_shift_db", "root", ""
            );

            UserDAO dao = new UserDAO(conn);
            UserBean user = dao.login(companyCode, username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                switch (user.getRole()) {
                    case "admin":
                        response.sendRedirect("admin_home.jsp");
                        break;
                    case "developer":
                        response.sendRedirect("developer_home.jsp");
                        break;
                    default:
                        response.sendRedirect("user_home.jsp");
                        break;
                }
            } else {
                request.setAttribute("error", "企業ID / ユーザーID / パスワードが正しくありません。");
                RequestDispatcher rd = request.getRequestDispatcher("/loginlogout/login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
