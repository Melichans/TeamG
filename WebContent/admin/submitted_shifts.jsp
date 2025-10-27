<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>シフト申請の管理</title>
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
        }
        th {
            background-color: #f4f4f4;
        }
        .action-buttons a {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            margin-right: 5px;
            color: white;
            font-size: 14px;
        }
        .btn-approve {
            background-color: #28a745; /* Green */
        }
        .btn-reject {
            background-color: #dc3545; /* Red */
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
                                            <a href="#" class="btn-approve">承認</a>
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
