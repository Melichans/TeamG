<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.UserBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理者ホーム - SSAI</title>
    <style>
        body { font-family: 'Yu Gothic', sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
        .header { background: #007bff; color: white; padding: 15px; border-radius: 5px 5px 0 0; }
        .content { background: white; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .user-info { margin-bottom: 20px; padding: 15px; background: #e9ecef; border-radius: 5px; }
        .menu { display: flex; gap: 15px; margin-top: 20px; }
        .menu a { padding: 10px 20px; background: #28a745; color: white; text-decoration: none; border-radius: 5px; }
        .menu a:hover { background: #218838; }
        .logout { float: right; margin-top: 10px; }
        .logout a { color: #dc3545; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <% 
        UserBean user = (UserBean) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }
    %>
    
    <div class="header">
        <h1>管理者ホーム</h1>
    </div>
    
    <div class="content">
        <div class="user-info">
            <h3>ようこそ、<%= user.getName() %>さん！</h3>
            <p><strong>会社:</strong> <%= user.getCompanyName() %></p>
            <p><strong>役職:</strong> <%= user.getPosition() %></p>
            <p><strong>メール:</strong> <%= user.getEmail() %></p>
        </div>
        
        <div class="menu">
            <a href="${pageContext.request.contextPath}/shift_list.jsp">シフト管理</a>
            <a href="${pageContext.request.contextPath}/user_list.jsp">ユーザー管理</a>
        </div>
        
        <div class="logout">
            <a href="${pageContext.request.contextPath}/loginlogout/logoutAction">ログアウト</a>
        </div>
    </div>
</body>
</html>