<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフトAI ログイン</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <h2>シフトAI</h2>
        <form action="login" method="post">
            <label>企業ID</label><br>
            <input type="text" name="companyId" required><br>

            <label>ユーザーID</label><br>
            <input type="text" name="userId" required><br>

            <label>パスワード</label><br>
            <input type="password" name="password" required><br>

            <button type="submit">ログイン</button>
        </form>
        <a href="#" class="forgot">パスワードを忘れた</a>
        <p style="color:red;">
            <%= request.getAttribute("errorMessage") == null ? "" : request.getAttribute("errorMessage") %>
        </p>
    </div>
</body>
</html>
