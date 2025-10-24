<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="${sessionScope.lang != null ? sessionScope.lang : 'ja'}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="menu.title" /></title>
    <link rel="stylesheet" href="../home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <%-- ✅ 先にロケールをセット、その後にバンドルを指定 --%>
    <fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'ja'}" />
    <fmt:setBundle basename="messages.messages" />

    <div class="content" style="text-align:center; margin-top:100px;">
        <h1><fmt:message key="menu.title" /></h1>
    </div>

    <!-- 言語切り替えリンク -->
    <div style="position: absolute; top: 10px; right: 10px;">
        <a href="${pageContext.request.contextPath}/ChangeLanguageServlet?lang=ja">日本語</a> |
        <a href="${pageContext.request.contextPath}/ChangeLanguageServlet?lang=en">English</a>
    </div>

    <footer style="text-align:center; margin-top:50px;">
        <nav style="display:flex; justify-content:center; gap:40px;">
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item active" style="text-decoration:none; color:#333;">
                <i class="fa-solid fa-calendar-alt"></i><br>
                <span><fmt:message key="menu.shift" /></span>
            </a>
            <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item" style="text-decoration:none; color:#333;">
                <i class="fa-solid fa-list-check"></i><br>
                <span><fmt:message key="menu.list" /></span>
            </a>
            <a href="${pageContext.request.contextPath}/notification/noticeList" class="nav-item" style="text-decoration:none; color:#333;">
                <i class="fa-solid fa-bell"></i><br>
                <span><fmt:message key="menu.notice" /></span>
            </a>
            <a href="${pageContext.request.contextPath}/loginlogout/logoutAction" class="nav-item" style="text-decoration:none; color:#333;">
                <i class="fa-solid fa-user"></i><br>
                <span><fmt:message key="menu.logout" /></span>
            </a>
        </nav>
    </footer>
</body>
</html>
