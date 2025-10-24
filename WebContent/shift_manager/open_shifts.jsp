<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>処理一覧 - SSAI</title>
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
        .shift-table .apply-btn {
            padding: 8px 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s ease;
        }
        .shift-table .apply-btn:hover {
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
            <div class="title">処理一覧</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="icon" title="ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <% if (request.getAttribute("error") != null) { %>
                <div class="message-box error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if (request.getParameter("message") != null) { %>
                <div class="message-box success">
                    <%= request.getParameter("message") %>
                </div>
            <% } %>

            <h2>募集中のシフト</h2>
            <div class="shift-table-container">
                <table class="shift-table">
                    <thead>
                        <tr>
                            <th>シフトID</th>
                            <th>日付</th>
                            <th>開始</th>
                            <th>終了</th>
                            <th>ステータス</th>
                            <th>アクション</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<ShiftBean> openShifts = (List<ShiftBean>) request.getAttribute("openShifts");
                            if (openShifts != null && !openShifts.isEmpty()) {
                                for (ShiftBean shift : openShifts) {
                        %>
                                    <tr>
                                        <td><%= shift.getShiftId() %></td>
                                        <td><%= shift.getShiftDate() %></td>
                                        <td><%= shift.getStartTime() %></td>
                                        <td><%= shift.getEndTime() %></td>
                                        <td><%= shift.getStatus() %></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/shift_manager/ApplyShiftExecuteAction" method="post">
                                                <input type="hidden" name="shiftId" value="<%= shift.getShiftId() %>">
                                                <button type="submit" class="apply-btn">登録</button>
                                            </form>
                                        </td>
                                    </tr>
                        <%      }
                            } else {
                        %>
                                <tr>
                                    <td colspan="6">現在募集中のシフトはありません。</td>
                                </tr>
                        <%  }
                        %>
                    </tbody>
                </table>
            </div>
        </main>

        <footer>
            <nav>
                <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
                <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item active"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
                <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
                <a href="${pageContext.request.contextPath}/loginlogout/logoutAction" class="nav-item"><i class="fa-solid fa-user"></i><span>ログアウト</span></a>
            </nav>
        </footer>
    </div>
</body>
</html>