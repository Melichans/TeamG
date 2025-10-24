<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>緊急シフト一覧 - SSAI</title>
    <link rel="stylesheet" href="../home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .shift-table-container {
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            margin-top: 20px;
        }
        .shift-table {
            width: 100%;
            border-collapse: collapse;
        }
        .shift-table th, .shift-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        .shift-table th {
            background-color: var(--light-color);
            font-weight: 600;
            color: var(--dark-color);
        }
        .shift-table tbody tr:last-child td {
            border-bottom: none;
        }
        .shift-table tbody tr:hover {
            background-color: #f5f5f5;
        }
        .add-button-container {
            text-align: right;
            margin-bottom: 20px;
        }
        .add-button {
            padding: 10px 20px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }
        .add-button:hover {
            background-color: #308acb;
        }
        .message-box {
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 15px;
            font-size: 14px;
        }
        .message-box.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .message-box.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">緊急シフト一覧</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/admin_home.jsp" class="icon" title="管理者ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <% if (request.getAttribute("error") != null) { %>
                <div class="message-box error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="message-box success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <div class="add-button-container">
                <a href="${pageContext.request.contextPath}/admin/add_urgent_shift.jsp" class="add-button">新しい緊急シフトを追加</a>
            </div>

            <h2>募集中の緊急シフト</h2>
            <div class="shift-table-container">
                <table class="shift-table">
                    <thead>
                        <tr>
                            <th>シフトID</th>
                            <th>日付</th>
                            <th>開始</th>
                            <th>終了</th>
                            <th>部署</th>
                            <th>ステータス</th>
                            <th>アクション</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<ShiftBean> urgentShifts = (List<ShiftBean>) request.getAttribute("urgentShifts");
                            if (urgentShifts != null && !urgentShifts.isEmpty()) {
                                for (ShiftBean shift : urgentShifts) {
                        %>
                                    <tr>
                                        <td><%= shift.getShiftId() %></td>
                                        <td><%= shift.getShiftDate() %></td>
                                        <td><%= shift.getStartTime() %></td>
                                        <td><%= shift.getEndTime() %></td>
                                        <td><%= shift.getDeptName() %></td>
                                        <td><%= shift.getStatus() %></td>
                                        <td>
                                            <!-- Admin actions like edit/delete could go here -->
                                            <!-- For now, just a placeholder or no action -->
                                            アクションなし
                                        </td>
                                    </tr>
                        <%      } 
                            } else { 
                        %>
                                <tr>
                                    <td colspan="7">現在、募集中の緊急シフトはありません。</td>
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