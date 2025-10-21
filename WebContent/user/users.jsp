<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.UserBean" %>
<html>
<head>
    <title>Users List</title>
</head>
<body>
    <h2>👥 Users Table</h2>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Username</th>
            <th>Role</th>
            <th>Position</th>
            <th>Email</th>
        </tr>
        <%
            List<UserBean> userList = (List<UserBean>) request.getAttribute("users");
            if (userList != null && !userList.isEmpty()) {
                for (UserBean user : userList) {
        %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getName() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getRoleName() %></td>
                <td><%= user.getPosition() %></td>
                <td><%= user.getEmail() %></td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="6">No data found</td></tr>
        <%
            }
        %>
    </table>
</body>
</html>
