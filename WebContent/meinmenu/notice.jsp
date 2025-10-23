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

        <!-- メインメニューに戻るリンク -->
        <div class="back-to-menu">
            <a href="menu.jsp">← メインメニューに戻る</a>
        </div>

        <!-- 全て既読にするボタン -->
        <div class="mark-all-read">
            <form action="MarkAllReadServlet" method="post">
                <button type="submit">全て既読にする</button>
            </form>
        </div>

        <!-- お知らせ一覧（仮のメッセージ） -->
        <div class="post">
            <p>お知らせはありません。</p>
        </div>
    </div>

    <!-- ナビバー -->
    <div class="navbar">
        <a href="#" class="nav-item disabled">
            <div class="icon">📅</div>
            シフト
        </a>
        <a href="board.jsp" class="nav-item">
            <div class="icon">💬</div>
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
