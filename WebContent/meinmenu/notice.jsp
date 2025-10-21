<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, bean.NoticeBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お知らせ</title>
<link rel="stylesheet" href="../css/style.css">
<style>
.notice-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 10px 20px;
}
.notice-container {
    max-width: 600px;
    margin: 0 auto 100px;
    background: #fff;
    border-radius: 12px;
    padding: 10px;
}
.notice-item {
    border-bottom: 1px solid #ddd;
    padding: 10px;
}
.notice-item:last-child {
    border-bottom: none;
}
.notice-title { font-weight: bold; color: #333; }
.notice-message { color: #555; margin: 3px 0; }
.notice-date { text-align: right; color: #888; font-size: 12px; }
</style>
</head>
<body>

<div class="notice-header">
    <h2>お知らせ</h2>
    <form action="../NoticeReadAllServlet" method="post">
        <button type="submit" style="background:none; border:none; color:#007bff; cursor:pointer;">
            全て既読
        </button>
    </form>
</div>

<div class="notice-container">
<%
    List<NoticeBean> notices = (List<NoticeBean>) request.getAttribute("notices");
    if (notices != null && !notices.isEmpty()) {
        for (NoticeBean n : notices) {
%>
    <div class="notice-item">
        <div class="notice-title"><%= n.getTitle() %></div>
        <div class="notice-message"><%= n.getMessage() %></div>
        <div class="notice-date"><%= n.getNoticeDate() %></div>
    </div>
<%
        }
    } else {
%>
    <p style="text-align:center;">お知らせはありません。</p>
<%
    }
%>
</div>

<!-- ナビバー -->
<div class="navbar">
    <a href="menu.jsp" class="nav-item">📅<div class="label">メニュー</div></a>
    <a href="notice.jsp" class="nav-item active">🔔<div class="label">お知らせ</div></a>
    <a href="user.jsp" class="nav-item">👤<div class="label">ユーザー</div></a>
</div>

</body>
</html>
