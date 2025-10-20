<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>パスワード変更</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <div class="header">
        <c:if test="${not empty user && not empty account}">
            <h2>${user.name}さんのプロフィール | 店員番号: ${account.username}</h2>
        </c:if>
        <c:if test="${empty user || empty account}">
            <h2>プロフィール | 店員番号: ----</h2>
        </c:if>
    </div>

    <div class="password-change-form">
        <h3>パスワード変更</h3>

        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
        <c:if test="${not empty success}">
            <p class="success-message">${success}</p>
        </c:if>

        <form action="passwordChange" method="post">
            <div class="form-group">
                <label for="current-password">現在のパスワード</label>
                <input type="password" id="current-password" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label for="new-password">新しいパスワード</label>
                <input type="password" id="new-password" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">新しいパスワード（確認）</label>
                <input type="password" id="confirm-password" name="confirmPassword" required>
            </div>
            <button type="submit" class="change-button">変更</button>
        </form>
        <a href="../home/home.jsp" class="back-link">メニューに戻る</a>
    </div>

    <div class="nav-bar">
        <button onclick="location.href='../shift/shift_list.jsp'">シフト</button>
        <button>処理一覧</button>
        <button>通知</button>
        <button>マイページ</button>
    </div>
</div>

</body>
</html>