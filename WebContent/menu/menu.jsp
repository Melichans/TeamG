<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>メインメニュー</title>
    <link rel="stylesheet" href="../home/css/style.css">
</head>
<body>
    <div class="content">
        <h1>メインメニュー</h1>
    </div>

    <footer>
        <nav>
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item active"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
            <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
            <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
            <a href="${pageContext.request.contextPath}/menu/mypage.jsp" class="nav-item"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
        </nav>
    </footer>
</body>
</html>
