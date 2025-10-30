<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>機能未実装</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .message-container {
            text-align: center;
            padding: 50px 20px;
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-top: 30px;
        }
        .message-container h2 {
            color: var(--dark-color);
            margin-bottom: 15px;
        }
        .message-container p {
            color: var(--text-color);
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">処理一覧</div>
        </header>

        <main>
            <div class="message-container">
                <h2><i class="fa-solid fa-gears"></i> この機能は現在利用できません</h2>
                <p>現在開発中のため、このページは表示できません。</p>
            </div>
        </main>

        <%@ include file="/menu/menu.jsp" %>
    </div>
</body>
</html>
