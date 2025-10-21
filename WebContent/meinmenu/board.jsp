<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        <!-- 投稿フォーム（管理者用・あとで制御） -->
        <form action="../BoardServlet" method="post" class="post-form">
            <textarea name="message" placeholder="お知らせ内容を入力してください"></textarea>
            <button type="submit">投稿</button>
        </form>

        <!-- 投稿一覧（仮のダミーデータ） -->
        <div class="post">
            <p><strong>管理者：</strong> 10月25日のシフトに入れる方いますか？</p>
            <div class="reactions">
                <form action="../BoardServlet" method="post">
                    <input type="hidden" name="postId" value="1">
                    <button name="action" value="good">○</button>
                    <button name="action" value="bad">×</button>
                </form>
                <span>○：3　×：1</span>
            </div>
        </div>

        <div class="post">
            <p><strong>管理者：</strong> 10月27日の朝シフト変更お願いします。</p>
            <div class="reactions">
                <form action="../BoardServlet" method="post">
                    <input type="hidden" name="postId" value="2">
                    <button name="action" value="good">○</button>
                    <button name="action" value="bad">×</button>
                </form>
                <span>○：0　×：2</span>
            </div>
        </div>
    </div>

    <div class="navbar">
        <a href="menu.jsp" class="nav-item">
            <div class="icon">📅</div>
            シフト
        </a>
        <a href="board.jsp" class="nav-item active">
            <div class="icon">💬</div>
            掲示板
        </a>
        <a href="notice.jsp" class="nav-item">
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
