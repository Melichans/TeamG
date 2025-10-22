package admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.NoticeBean;
import dao.NoticeDAO;

@WebServlet("/admin/addNoticeExecute")
public class AddNoticeAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String title = request.getParameter("title");
        String message = request.getParameter("message");

        if (title == null || title.trim().isEmpty() || message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "タイトルとメッセージは必須です。");
            request.getRequestDispatcher("/admin/add_notice.jsp").forward(request, response);
            return;
        }

        NoticeBean notice = new NoticeBean();
        notice.setTitle(title);
        notice.setMessage(message);
        notice.setNoticeDate(new Date()); // Set current date
        notice.setIsRead(false); // New notices are unread by default

        NoticeDAO noticeDAO = new NoticeDAO();
        try {
            noticeDAO.addNotice(notice);
            request.setAttribute("success", "お知らせが正常に追加されました。");
            request.getRequestDispatcher("/admin/add_notice.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "お知らせの追加中にエラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/admin/add_notice.jsp").forward(request, response);
        }
    }
}