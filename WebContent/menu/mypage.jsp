<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイページ</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
    /* Specific styles for the mypage menu list to be placed in a container */
    .page-content {
        padding: 20px;
    }
    .mypage-menu {
        max-width: 600px; /* Give the menu a max-width for better appearance */
        margin: 0 auto;
        list-style: none;
        padding: 0;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .mypage-menu li {
        border-bottom: 1px solid #eee;
    }
    .mypage-menu li:last-child {
        border-bottom: none;
    }
    .mypage-menu li a {
        display: flex;
        align-items: center;
        padding: 18px 15px;
        text-decoration: none;
        color: #333;
        font-weight: bold;
        transition: background-color 0.2s ease-in-out;
    }
    .mypage-menu li a:hover {
        background-color: #f7f7f7;
    }
    .mypage-menu i.fa-solid {
        margin-right: 15px;
        width: 20px;
        text-align: center;
        color: #555;
    }
</style>
</head>
<body>

<div class="container">

    <header>
        <div class="header-icons"></div>
        <div class="title-container">
            <h1 class="title">マイページ</h1>
        </div>
        <div class="header-icons"></div>
    </header>

    <main>
        <div class="page-content">
            <ul class="mypage-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/password_change/password_change.jsp">
                        <i class="fa-solid fa-key"></i>
                        <span>パスワード変更</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/loginlogout/logoutAction">
                        <i class="fa-solid fa-right-from-bracket"></i>
                        <span>ログアウト</span>
                    </a>
                </li>
            </ul>
        </div>
    </main>

    <footer>
        <nav>
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
            <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
            <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
            <a href="${pageContext.request.contextPath}/menu/mypage.jsp" class="nav-item active"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
        </nav>
    </footer>

</div>

</body>
</html>
