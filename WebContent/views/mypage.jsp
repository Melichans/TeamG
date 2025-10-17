<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>マイページ</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="mypage-container">
        <h3>プロフィール</h3>
        <div class="profile-box">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="profile-img">
            <div>
                <p>名前: テストユーザー</p>
                <p>コード: 011888111</p>
            </div>
        </div>
        <form action="logout" method="post">
            <button type="submit" class="logout-btn">ログアウト</button>
        </form>
    </div>

    <div class="navbar">
        <button>シフト</button>
        <button>処理一覧</button>
        <button>通知</button>
        <button class="active">マイページ</button>
    </div>
</body>
</html>
