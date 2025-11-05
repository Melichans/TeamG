<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフト管理 - SSAI</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <header>
            <div class="title">シフト管理</div>
            <div class="header-icons">
                 <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="icon" title="マイページ"><i class="fa-solid fa-user"></i></a>
            </div>
        </header>

        <main>
            <section class="admin-menu">
                <a href="${pageContext.request.contextPath}/admin/ListSubmittedShiftsAction" class="menu-item">
                    <i class="fa-solid fa-inbox"></i>
                    <span>シフト提出</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/ListAllShiftsAction" class="menu-item">
                    <i class="fa-solid fa-pen-to-square"></i>
                    <span>シフト修正</span>
                </a>
            </section>
            <div class="back-link-container">
                <a href="${pageContext.request.contextPath}/home/admin_home.jsp" class="back-link">管理者ホームに戻る</a>
            </div>
        </main>

        <!-- Footer -->
        <footer>
            <p>&copy; 2025 Shift AI. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
