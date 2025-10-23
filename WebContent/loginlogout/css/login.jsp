<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>SSAI ログイン</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-container">
        <!-- Logo -->
        <img src="${pageContext.request.contextPath}/images/logo.svg" alt="Smart Shift AI Logo" class="logo">

        <form action="${pageContext.request.contextPath}/loginlogout/loginExecute" method="post">
            <div class="form-group">
                <label>企業ID</label>
                <input type="text" name="company_id" required>
            </div>

            <div class="form-group">
                <label>ユーザーID</label>
                <input type="text" name="user_id" required>
            </div>

            <div class="form-group">
                <label>パスワード</label>
                <input type="password" name="password" required>
            </div>

            <input type="submit" value="ログイン" class="login-button">
            
            <div class="forgot">
                <a href="#">パスワード忘れた</a>
            </div>

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>
        </form>
    </div>
</body>
</html>
