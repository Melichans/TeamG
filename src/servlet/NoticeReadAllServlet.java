import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDAO;

@WebServlet("/NoticeReadAllServlet")
public class NoticeReadAllServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NoticeDAO dao = new NoticeDAO();
        dao.markAllAsRead();
        response.sendRedirect("NoticeServlet"); // 一覧ページへ戻る
    }
}
