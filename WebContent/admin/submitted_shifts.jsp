<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフト申請の管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/submitted_shifts.css">
    <style>
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
            <div class="title">シフト申請の管理</div>
             <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/admin_home.jsp" class="icon" title="ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <div class="filter-container">
                <form action="${pageContext.request.contextPath}/admin/ListSubmittedShiftsAction" method="get" id="userFilterForm">
                    <label for="selectedUserId">ユーザーで絞り込み:</label>
                    <select name="selectedUserId" id="selectedUserId" onchange="document.getElementById('userFilterForm').submit();">
                        <option value="all">すべてのユーザー</option>
                        <c:forEach var="user" items="${userList}">
                            <option value="${user.userId}" ${user.userId == selectedUserId ? 'selected' : ''}>${user.name}</option>
                        </c:forEach>
                    </select>
                </form>
            </div>

            <div class="table-container">
                <c:if test="${not empty error}">
                    <p style="color: red;"><c:out value="${error}" /></p>
                </c:if>
                
                <table>
                    <thead>
                        <tr>
                            <th>申請者</th>
                            <th>日付</th>
                            <th>時間</th>
                            <th>部署</th>
                            <th>ステータス</th>
                            <th>アクション</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty submittedShifts}">
                                <c:forEach var="shift" items="${submittedShifts}">
                                    <tr>
                                        <td><c:out value="${shift.userName}" /></td>
                                        <td><fmt:formatDate value="${shift.shiftDate}" pattern="yyyy-MM-dd" /></td>
                                        <td>
                                            <fmt:formatDate value="${shift.startTime}" pattern="HH:mm" /> - 
                                            <fmt:formatDate value="${shift.endTime}" pattern="HH:mm" />
                                        </td>
                                        <td><c:out value="${shift.deptName}" /></td>
                                        <td><span class="status-submitted"><c:out value="${shift.status}" /></span></td>
                                        <td class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/ApproveShiftAction?shiftId=${shift.shiftId}" class="btn-approve">承認</a>
                                            <a href="${pageContext.request.contextPath}/admin/RejectShiftAction?shiftId=${shift.shiftId}" class="btn-reject" onclick="return confirm('このシフト申請を拒否してもよろしいですか？');">拒否</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6">現在、新しいシフト申請はありません。</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
             <div class="back-link-container">
                <a href="${pageContext.request.contextPath}/admin/shift_management_menu.jsp" class="back-link">シフト管理に戻る</a>
            </div>
        </main>
    </div>
</body>
</html>
