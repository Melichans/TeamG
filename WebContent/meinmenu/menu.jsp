<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>メニュー</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="content">
        <h2>メインメニュー</h2>
        <p>ここにメインの内容を表示します。</p>
    </div>

    <!-- ナビゲーションバー -->
    <div class="navbar">
        <a href="menu.jsp" class="nav-item active">
            <div class="icon">📅</div>
            <div class="label">シフト</div>
        </a>
        <a href="notice.jsp" class="nav-item">
            <div class="icon">🔔</div>
            <div class="label">お知らせ</div>
        </a>
        <a href="user.jsp" class="nav-item">
            <div class="icon">👤</div>
            <div class="label">ユーザー</div>
        </a>
    </div>
</body>
</html>
