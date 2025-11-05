<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新規シフト追加 - SSAI</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="date"],
        .form-group input[type="time"],
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-actions {
            text-align: right;
        }
        .submit-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">新規シフト追加</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="icon" title="マイページ"><i class="fa-solid fa-user"></i></a>
            </div>
        </header>

        <main>
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/admin/AdminAddShiftExecuteAction" method="post">
                    <div class="form-group">
                        <label for="userId">ユーザー</label>
                        <select id="userId" name="userId" required>
                            <c:forEach var="user" items="${userList}">
                                <option value="${user.userId}">${user.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="deptId">店舗</label>
                        <select id="deptId" name="deptId" required>
                            <c:forEach var="dept" items="${departmentList}">
                                <option value="${dept.deptId}">${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="shiftDate">勤務日</label>
                        <input type="date" id="shiftDate" name="shiftDate" required>
                    </div>
                    <div class="form-group">
                        <label for="startTime">開始時間</label>
                        <input type="time" id="startTime" name="startTime" required>
                    </div>
                    <div class="form-group">
                        <label for="endTime">終了時間</label>
                        <input type="time" id="endTime" name="endTime" required>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="submit-button">追加</button>
                    </div>
                </form>
            </div>

            <div class="back-link-container">
                <a href="${pageContext.request.contextPath}/admin/ListAllShiftsAction" class="back-link">シフト修正に戻る</a>
            </div>
        </main>

        <footer>
            <p>&copy; 2025 Shift AI. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
