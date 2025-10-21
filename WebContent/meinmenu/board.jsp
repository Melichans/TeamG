<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>掲示板</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="content">
    <h1>掲示板</h1>

    <!-- メインメニューに戻るリンク -->
    <div class="back-to-menu">
        <a href="<%=request.getContextPath()%>/menu.jsp">← メインメニューに戻る</a>
    </div>

    <!-- 投稿フォーム -->
    <form action="<%=request.getContextPath()%>/BoardServlet" method="post" class="post-form">
        <textarea name="message" placeholder="お知らせ内容を入力してください"></textarea>
        <button type="submit">投稿</button>
    </form>

    <!-- 投稿一覧をDBから表示 -->
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT b.message, b.created_at, u.name " +
                         "FROM board_posts b " +
                         "JOIN user u ON b.user_id = u.user_id " +
                         "ORDER BY b.created_at DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
    %>
        <div class="post">
            <p><strong><%= rs.getString("name") %>：</strong> <%= rs.getString("message") %></p>
            <span><%= rs.getTimestamp("created_at") %></span>
        </div>
    <%
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
            if(conn != null) conn.close();
        }
    %>
</div>

<div class="navbar">
    <a href="#" class="nav-item disabled">
        <div class="icon">📅</div>
        シフト
    </a>
    <a href="<%=request.getContextPath()%>/board.jsp" class="nav-item active">
        <div class="icon">💬</div>
        掲示板
    </a>
    <a href="<%=request.getContextPath()%>/notice.jsp" class="nav-item">
        <div class="icon">🔔</div>
        お知らせ
    </a>
    <a href="<%=request.getContextPath()%>/user.jsp" class="nav-item">
        <div class="icon">👤</div>
        マイページ
    </a>
</div>
</body>
</html>
