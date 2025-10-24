<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'ja'}">
<head>
    <meta charset="UTF-8">

    <!-- 言語設定 -->
    <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'ja'}" />
    <fmt:setBundle basename="messages.messages" />

    <title><fmt:message key="login.title" /></title>

    <style>
        body { 
            font-family: 'Yu Gothic', sans-serif; 
            text-align: center; 
            margin-top: 60px; 
            background-color: #f5f5f5;
        }
        .login-container {
            width: 350px;
            margin: 0 auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .login-container h2 {
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 15px;
        }
        .login-btn:hover {
            background-color: #0056b3;
        }
        .error {
            color: #dc3545;
            margin-top: 15px;
            font-size: 14px;
        }
        .lang-switch {
            margin-bottom: 15px;
            text-align: right;
        }
        .lang-switch a {
            color: #007bff;
            text-decoration: none;
            margin: 0 5px;
        }
        .lang-switch a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- 言語切り替え -->
        <div class="lang-switch">
            <a href="${pageContext.request.contextPath}/ChangeLanguageServlet?lang=ja">日本語</a> |
            <a href="${pageContext.request.contextPath}/ChangeLanguageServlet?lang=en">English</a>
        </div>

        <h2><fmt:message key="login.header" /></h2>

        <form action="${pageContext.request.contextPath}/loginlogout/loginExecute" method="post">
            <div class="form-group">
                <label><fmt:message key="login.companyId" /></label>
                <input type="text" name="companyCode" placeholder="COMP001" required>
            </div>

            <div class="form-group">
                <label><fmt:message key="login.userId" /></label>
                <input type="text" name="username" placeholder="admin" required>
            </div>

            <div class="form-group">
                <label><fmt:message key="login.password" /></label>
                <input type="password" name="password" placeholder="admin123" required>
            </div>

            <button type="submit" class="login-btn"><fmt:message key="login.button" /></button>
        </form>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    </div>
</body>
</html>

