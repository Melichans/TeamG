package servlet; // 既存のサーブレットパッケージ名に合わせてください

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 既存の DBConnection を使用
import util.DBConnection;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 投稿処理
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字化け対策
        request.setCharacterEncoding("UTF-8");

        // セッションからログイン中ユーザーIDを取得
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            // ログインしていなければログイン画面へ
            response.sendRedirect("login.jsp");
            return;
        }

        // フォームから投稿内容を取得
        String message = request.getParameter("message");

        // DBに保存
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO board_posts (user_id, message) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, message);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 投稿後に掲示板ページにリダイレクト
        response.sendRedirect("board.jsp");
    }

    // GETリクエストは掲示板ページにリダイレクト
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("board.jsp");
    }
}

