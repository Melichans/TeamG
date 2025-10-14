<%@a page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Users List</title>
</head>
<body>
    <h2>👥 Users Table</h2>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>ID</th><th>Username</th><th>Password</th><th>Role</th>
        </tr>
        <%
            java.sql.ResultSet rs = (java.sql.ResultSet) request.getAttribute("users");
            if (rs != null) {
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("password") %></td>
                <td><%= rs.getString("role") %></td>
            </tr>
        <%
                }
                rs.beforeFirst(); // reset resultset (tùy trường hợp)
            } else {
        %>
            <tr><td colspan="4">No data found</td></tr>
        <%
            }
        %>
    </table>
</body>
</html>
