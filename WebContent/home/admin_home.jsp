<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bean.UserBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理者ホーム - SSAI</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
    <% 
        UserBean user = (UserBean) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/loginlogout/loginAction");
            return;
        }
    %>
    
    <div class="container">
        <!-- Header -->
        <header>
            <div class="title">管理者ホーム</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="icon" title="マイページ"><i class="fa-solid fa-user"></i></a>
            </div>
        </header>

        <main>
            <!-- User Info -->
            <section class="user-info-card">
                <h3>ようこそ、<%= user.getName() %>さん！</h3>
                <p><i class="fa-solid fa-building"></i> <strong>会社:</strong> <%= user.getCompanyName() %></p>
                <p><i class="fa-solid fa-user-tie"></i> <strong>役職:</strong> <%= user.getPosition() %></p>
                <p><i class="fa-solid fa-envelope"></i> <strong>メール:</strong> <%= user.getEmail() %></p>
            </section>

            <!-- Menu -->
            <section class="admin-menu">
                <a href="${pageContext.request.contextPath}/admin/ListSubmittedShiftsAction" class="menu-item">
                    <i class="fa-solid fa-inbox"></i>
                    <span>シフト提出確認</span>
                </a>
                <a href="${pageContext.request.contextPath}/user_list.jsp" class="menu-item">
                    <i class="fa-solid fa-users-cog"></i>
                    <span>ユーザー管理</span>
                </a>
                <div class="admin-menu-row">
                    <a href="${pageContext.request.contextPath}/admin/ListUrgentShiftsAction" class="menu-item new-feature">
                        <i class="fa-solid fa-clipboard-list"></i>
                        <span>掲示板</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/add_notice.jsp" class="menu-item">
                        <i class="fa-solid fa-bullhorn"></i>
                        <span>お知らせ追加</span>
                    </a>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer>
            <p>&copy; 2025 Shift AI. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>