import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.NoticeBean;
import dao.NoticeDAO;

@WebServlet("/NoticeServlet")
public class NoticeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NoticeDAO dao = new NoticeDAO();
        List<NoticeBean> notices = dao.getAllNotices();

        request.setAttribute("notices", notices);
        RequestDispatcher rd = request.getRequestDispatcher("mainmenu/notice.jsp");
        rd.forward(request, response);
    }
}
