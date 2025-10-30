<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<footer>
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
        <a href="${pageContext.request.contextPath}/shift/process_list.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
        <a href="${pageContext.request.contextPath}/noticafition/notice_menu.jsp" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
        <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="nav-item"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
    </nav>
</footer>