<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>通知メニュー</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/home/css/style.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
.notice-menu {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 20px;
}

.menu-item {
    display: flex;
    align-items: center;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-decoration: none;
    color: #333;
    transition: transform 0.2s;
}

.menu-item:hover {
    transform: translateY(-5px);
}

.menu-item i {
    font-size: 24px;
    margin-right: 15px;
    color: #007bff;
}
</style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">通知</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/mypage/my_page.jsp"
                    class="icon" title="マイページ"><i class="fa-solid fa-user"></i></a>
            </div>
        </header>

        <main>
            <section class="notice-menu">
                <a href="${pageContext.request.contextPath}/noticafition/noticeList"
                    class="menu-item"> <i class="fa-solid fa-bullhorn"></i>
                    <span>お知らせ</span>
                </a>
                <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="menu-item">
                    <i class="fa-solid fa-clipboard-list"></i> <span>掲示板</span>
                </a>
            </section>
        </main>

        <%@ include file="/menu/menu.jsp"%>
    </div>
</body>
</html>