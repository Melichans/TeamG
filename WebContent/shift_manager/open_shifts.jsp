<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.ShiftBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ca làm việc đang tuyển - Shift_AI</title>
    <style>
        body { font-family: 'Yu Gothic', sans-serif; margin: 0; padding: 20px; background-color: #f5f5f5; }
        .header { background: #007bff; color: white; padding: 15px; border-radius: 5px 5px 0 0; padding-left: 20px; }
        .content { background: white; padding: 20px; border-radius: 0 0 5px 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .error { color: #dc3545; margin-top: 10px; }
        .message { color: #28a745; margin-top: 10px; }
        .apply-btn { padding: 5px 10px; background: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer; }
        .apply-btn:hover { background: #218838; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Ca làm việc đang tuyển</h1>
    </div>
    
    <div class="content">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <% if (request.getParameter("message") != null) { %>
            <div class="message">
                <%= request.getParameter("message") %>
            </div>
        <% } %>

        <h2>Danh sách ca làm việc đang tuyển</h2>
        <table>
            <thead>
                <tr>
                    <th>ID Ca</th>
                    <th>Ngày</th>
                    <th>Bắt đầu</th>
                    <th>Kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
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
                                        <button type="submit" class="apply-btn">Đăng ký</button>
                                    </form>
                                </td>
                            </tr>
                <%      }
                    } else {
                %>
                        <tr>
                            <td colspan="6">Không có ca làm việc nào đang tuyển.</td>
                        </tr>
                <%  }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>