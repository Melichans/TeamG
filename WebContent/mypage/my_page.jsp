<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>マイページ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/mypage/css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>マイページ</h1>
        </div>

        <div class="content-area">
            <%-- Display success/error messages from session --%>
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
                    <div class="profile-item">
                        <span class="label">言語設定</span>
                        <select name="language" class="language-select">
                            <option value="ja" <c:if test="${user.language == 'ja'}">selected</c:if>>日本語</option>
                            <option value="en" <c:if test="${user.language == 'en'}">selected</c:if>>English</option>
                        </select>
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
                    <a href="${pageContext.request.contextPath}/loginlogout/logout" class="action-button logout">ログアウト</a>
                </div>
            </div>
        </div>

        <!-- Bottom Navigation Bar -->
        <div class="nav-bar">
            <button onclick="location.href='../shift/shift_list.jsp'">シフト</button>
            <button>処理一覧</button>
            <button>通知</button>
            <button class="active" onclick="location.href='${pageContext.request.contextPath}/mypage/myPage'">マイページ</button>
        </div>
    </div>
</body>
</html>
