<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.ShiftBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフト修正 - SSAI</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .shift-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .shift-table th, .shift-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .shift-table th {
            background-color: #f2f2f2;
        }
        .action-button {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }
        .delete-button { background-color: #f44336; }
        .add-button-container {
            margin-top: 20px;
            text-align: right;
        }
        .add-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .filter-container {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .filter-container label {
            font-weight: bold;
            margin-right: 10px;
        }
        .filter-container select {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">シフト修正</div>
             <div class="header-icons">
                 <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="icon" title="マイページ"><i class="fa-solid fa-user"></i></a>
            </div>
        </header>

        <main>
            <c:if test="${not empty error}">
                <p style="color: red; font-weight: bold;"><c:out value="${error}" /></p>
            </c:if>

            <div class="filter-container">
                <form action="${pageContext.request.contextPath}/admin/ListAllShiftsAction" method="get" id="userFilterForm">
                    <label for="selectedUserId">ユーザーで絞り込み:</label>
                    <select name="selectedUserId" id="selectedUserId" onchange="document.getElementById('userFilterForm').submit();">
                        <option value="all">すべてのユーザー</option>
                        <c:forEach var="user" items="${userList}">
                            <option value="${user.userId}" ${user.userId == selectedUserId ? 'selected' : ''}>${user.name}</option>
                        </c:forEach>
                    </select>
                </form>
            </div>

            <div class="add-button-container">
                <a href="${pageContext.request.contextPath}/admin/AdminAddShiftAction" class="add-button">新規シフト追加</a>
            </div>

            <table class="shift-table">
                <thead>
                    <tr>
                        <th>勤務日</th>
                        <th>ユーザー名</th>
                        <th>店舗</th>
                        <th>勤務時間</th>
                        <th>ステータス</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty shiftList}">
                        <tr>
                            <td colspan="6">修正対象のシフトはありません。</td>
                        </tr>
                    </c:if>
                    <c:forEach var="shift" items="${shiftList}">
                        <tr>
                            <td><fmt:formatDate value="${shift.shiftDate}" pattern="yyyy-MM-dd" /></td>
                            <td><c:out value="${shift.userName}" /></td>
                            <td><c:out value="${shift.deptName}" /></td>
                            <td>
                                <fmt:formatDate value="${shift.startTime}" pattern="HH:mm" /> - 
                                <fmt:formatDate value="${shift.endTime}" pattern="HH:mm" />
                            </td>
                            <td><c:out value="${shift.status}" /></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/DeleteShiftAction" method="post" onsubmit="return confirm('このシフトを削除してもよろしいですか？');">
                                    <input type="hidden" name="shiftId" value="${shift.shiftId}">
                                    <button type="submit" class="action-button delete-button">削除</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="back-link-container">
                <a href="${pageContext.request.contextPath}/admin/shift_management_menu.jsp" class="back-link">シフト管理に戻る</a>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Shift AI. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
