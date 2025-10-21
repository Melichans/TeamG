<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>お知らせ</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="content">
        <h1>お知らせ</h1>
         <div class="header-buttons">
        <a href="menu.jsp" class="menu-button">メインメニューへ</a>
        <a href="#" class="mark-read">全て既読</a>
         </div>
        <div class="notice-box">
            お知らせはありません。
        </div>
    </div>

    <div class="navbar">
        <a href="menu.jsp" class="nav-item">
            <div class="icon">📅</div>
            シフト
        </a>
        <a href="#" class="nav-item">
            <div class="icon">✅</div>
            掲示板
        </a>
        <a href="notice.jsp" class="nav-item active">
            <div class="icon">🔔</div>
            お知らせ
        </a>
        <a href="user.jsp" class="nav-item">
            <div class="icon">👤</div>
            マイページ
        </a>
    </div>
</body>
</html>
