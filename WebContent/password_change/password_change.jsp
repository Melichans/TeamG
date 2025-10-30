<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>パスワード変更</title>
    <%-- Use the main shared stylesheet for consistency --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Minor adjustments for form content within the main layout */
        .page-content {
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container">

    <header>
        <div class="header-icons">
             <a href="${pageContext.request.contextPath}/menu/mypage.jsp" class="icon"><i class="fa-solid fa-arrow-left"></i></a>
        </div>
        <div class="title-container">
            <h1 class="title">パスワード変更</h1>
        </div>
        <div class="header-icons"></div>
    </header>

    <main>
        <div class="page-content">
            <div class="form-container">
                <div class="header-info" style="text-align: center; margin-bottom: 20px;">
                    <c:if test="${not empty user && not empty account}">
                        <h4>${user.name}さんのプロフィール | 店員番号: ${account.username}</h4>
                    </c:if>
                    <c:if test="${empty user || empty account}">
                        <h4>プロフィール | 店員番号: ----</h4>
                    </c:if>
                </div>

                <c:if test="${not empty error}">
                    <p class="error-message" style="padding: 10px; border-radius: 4px; text-align: center; margin-bottom: 20px; color: #d9534f; background-color: #f2dede; border: 1px solid #ebccd1;">${error}</p>
                </c:if>
                <c:if test="${not empty success}">
                    <p class="success-message" style="padding: 10px; border-radius: 4px; text-align: center; margin-bottom: 20px; color: #5cb85c; background-color: #dff0d8; border: 1px solid #d6e9c6;">${success}</p>
                </c:if>

                <form action="passwordChange" method="post">
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label for="current-password" style="display: block; margin-bottom: 5px;">現在のパスワード</label>
                        <input type="password" id="current-password" name="currentPassword" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label for="new-password" style="display: block; margin-bottom: 5px;">新しいパスワード</label>
                        <input type="password" id="new-password" name="newPassword" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                    </div>
                    <div class="form-group" style="margin-bottom: 20px;">
                        <label for="confirm-password" style="display: block; margin-bottom: 5px;">新しいパスワード（確認）</label>
                        <input type="password" id="confirm-password" name="confirmPassword" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;">
                    </div>
                    <button type="submit" class="change-button" style="width: 100%; padding: 12px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">変更</button>
                </form>
            </div>
        </div>
    </main>

    <footer>
        <nav>
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
            <a href="${pageContext.request.contextPath}/shift/process_list.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
            <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
            <a href="${pageContext.request.contextPath}/menu/mypage.jsp" class="nav-item active"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
        </nav>
    </footer>

</div>

</body>
</html>