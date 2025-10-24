<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>マイページ</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
        <c:if test="${not empty sessionScope.successMessage}">
            <p class="success-message">${sessionScope.successMessage}</p>
            <c:remove var="successMessage" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <p class="error-message">${sessionScope.errorMessage}</p>
            <c:remove var="errorMessage" scope="session" />
        </c:if>
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>

        <%-- Account Info Section --%>
        <div class="section">
            <h2>アカウント情報</h2>
            <div class="profile-item">
                <span class="label">氏名</span>
                <span class="value">${user.name}</span>
            </div>
            <div class="profile-item">
                <span class="label">店員番号</span>
                <span class="value">${account.username}</span>
            </div>
            <div class="profile-item">
                <span class="label">役職</span>
                <span class="value">${user.position}</span>
            </div>
            <div class="profile-item">
                <span class="label">電話番号</span>
                <span class="value">${user.phone}</span>
            </div>
            <div class="profile-item">
                <span class="label">メールアドレス</span>
                <span class="value">${user.email}</span>
            </div>
            <div class="profile-item">
                <span class="label">入社日</span>
                <span class="value">${user.joinedDate}</span>
            </div>
            <div class="actions">
                 <a href="#" class="action-button edit-info">アカウント情報編集</a>
            </div>
        </div>

        <%-- Settings Section --%>
        <div class="section">
            <h2>設定</h2>
            <form action="${pageContext.request.contextPath}/mypage/updateSettings" method="post">
                <div class="profile-item">
                    <span class="label">プッシュ通知</span>
                    <label class="toggle-switch">
                        <input type="checkbox" name="push_notifications_enabled" <c:if test="${user.pushNotificationsEnabled}">checked</c:if>>
                        <span class="slider"></span>
                    </label>
                </div>
                <div class="actions">
                    <button type="submit" class="action-button">設定を保存</button>
                </div>
            </form>
        </div>

        <%-- Other Actions --%>
        <div class="section">
             <div class="actions">
                <a href="${pageContext.request.contextPath}/password/passwordChange" class="action-button">パスワード変更</a>
                <a href="${pageContext.request.contextPath}/loginlogout/logoutAction" class="action-button logout">ログアウト</a>
            </div>
        </div>
    </main>

    <footer>
        <nav>
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
            <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
            <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
            <a href="${pageContext.request.contextPath}/mypage/myPage" class="nav-item active"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
        </nav>
    </footer>

</div>

</body>
</html>