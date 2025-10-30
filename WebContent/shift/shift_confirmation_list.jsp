<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>承認済みシフトの確認</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .table-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        }
        th {
            background-color: #f4f4f4;
        }
        .form-actions {
            text-align: right;
            margin-top: 20px;
        }
        .btn-confirm {
            padding: 12px 30px;
            background-color: #28a745; /* Green */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-confirm:hover {
            background-color: #218838;
        }
        .no-shifts-message {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">シフト確認</div>
        </header>

        <main>
            <div class="table-container">
                <form action="${pageContext.request.contextPath}/shift/ConfirmShiftsAction" method="post">
                    <% 
                        List<ShiftBean> shifts = (List<ShiftBean>) request.getAttribute("confirmationList");
                        if (shifts != null && !shifts.isEmpty()) {
                    %>
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="select-all"></th>
                                    <th>日付</th>
                                    <th>時間</th>
                                    <th>部署</th>
                                    <th>ステータス</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (ShiftBean shift : shifts) { %>  
                                    <tr>
                                        <td><input type="checkbox" name="shiftIds" value="<%= shift.getShiftId() %>"></td>
                                        <td><%= shift.getShiftDate() %></td>
                                        <td><%= shift.getStartTime() %> - <%= shift.getEndTime() %></td>
                                        <td><%= shift.getDeptName() %></td>
                                        <td><span class="status-approved"><%= shift.getStatus() %></span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <div class="form-actions">
                            <button type="submit" class="btn-confirm">選択したシフトを確定</button>
                        </div>
                    <% } else { %>
                        <div class="no-shifts-message">
                            <p>現在、確認待ちのシフトはありません。</p>
                        </div>
                    <% } %> 
                </form>
            </div>
        </main>

        <%@ include file="/menu/menu.jsp" %>
    </div>

    <script>
        document.getElementById('select-all').addEventListener('click', function(event) {
            const checkboxes = document.querySelectorAll('input[name="shiftIds"]');
            for (const checkbox of checkboxes) {
                checkbox.checked = event.target.checked;
            }
        });
    </script>
</body>
</html>
