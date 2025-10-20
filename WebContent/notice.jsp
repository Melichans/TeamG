<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, bean.NoticeBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お知らせ</title>
<link rel="stylesheet" href="css/style.css">
<style>
.notice-container {
    max-width: 600px;
    margin: 60px auto 100px;
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
.notice-title {
    font-weight: bold;
    color: #333;
}
.notice-message {
    color: #555;
    margin: 3px 0;
}
.notice-date {
    text-align: right;
    color: #888;
    font-size: 12px;
}
</style>
</head>
<body>

<h2 style="text-align:center;">お知らせ</h2>

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

<!-- メニューと同じナビバー -->
<div class="navbar">
    <a href="shift.jsp" class="nav-item">📅<div class="label">シフト</div></a>
    <a href="list.jsp" class="nav-item">✅<div class="label">対応リスト</div></a>
    <a href="NoticeServlet" class="nav-item active">🔔<div class="label">お知らせ</div></a>
    <a href="mypage.jsp" class="nav-item">👤<div class="label">マイページ</div></a>
</div>

</body>
</html>
