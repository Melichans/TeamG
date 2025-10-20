<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
    <meta charset="UTF-8">
    <title>SSAI ログイン</title>
    <style>
        body { font-family: 'Yu Gothic', sa
        ns-serif; text-align: center; margin-top: 60px; }
        input { display: block; margin: 10px auto; padding: 8px; width: 200px; border: 1px solid #000; }
        .forgot { text-align: right; width: 230px; margin: auto; }
        .forgot a { font-size: 12px; color: #00f; text-decoration: none; }
        .forgot a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/loginlogout/loginExecute" method="post">

    <h2>SSAI</h2>
    <form action="loginExecute" method="post">
        <label>企業ID</label>
        <input type="text" name="company_id" required>

        <label>ユーザーID</label>
        <input type="text" name="user_id" required>

        <label>パスワード</label>
        <input type="password" name="password" required>

        <input type="submit" value="ログイン">
        <div class="forgot">
            <a href="#">パスワード忘れた</a>
        </div>

        <p style="color:red;">
            ${error}
        </p>
    </form>
</body>
</html>
