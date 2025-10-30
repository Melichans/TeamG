<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフト申請の管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/submitted_shifts.css">
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
            <div class="table-container">
                <% if (request.getAttribute("error") != null) { %>
                    <p style="color: red;"><%= request.getAttribute("error") %></p>
                <% } %>
                
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
                        <% 
                            List<ShiftBean> shifts = (List<ShiftBean>) request.getAttribute("submittedShifts");
                            if (shifts != null && !shifts.isEmpty()) {
                                for (ShiftBean shift : shifts) {
                        %>  
                                    <tr>
                                        <td><%= shift.getUserName() %></td>
                                        <td><%= shift.getShiftDate() %></td>
                                        <td><%= shift.getStartTime() %> - <%= shift.getEndTime() %></td>
                                        <td><%= shift.getDeptName() %></td>
                                        <td><span class="status-submitted"><%= shift.getStatus() %></span></td>
                                        <td class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/ApproveShiftAction?shiftId=<%= shift.getShiftId() %>" class="btn-approve">承認</a>
                                            <a href="#" class="btn-reject">拒否</a>
                                        </td>
                                    </tr>
                        <%      }
                            } else { %>
                                <tr>
                                    <td colspan="6">現在、新しいシフト申請はありません。</td>
                                </tr>
                        <%  }
                        %> 
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
