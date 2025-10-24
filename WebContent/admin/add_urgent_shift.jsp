<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.DepartmentBean" %>
<%@ page import="dao.DepartmentDAO" %>
<%@ page import="util.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>緊急シフト追加 - SSAI</title>
    <link rel="stylesheet" href="../home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .form-container {
            background-color: var(--white);
            padding: 25px;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            max-width: 500px;
            margin: 30px auto;
        }
        .form-container h2 {
            text-align: center;
            color: var(--dark-color);
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-color);
        }
        .form-group input[type="date"],
        .form-group input[type="time"],
        .form-group select {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-actions {
            text-align: center;
            margin-top: 25px;
        }
        .form-actions button {
            padding: 12px 25px;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
        .form-actions button:hover {
            background-color: #308acb;
        }
        .error-message {
            color: var(--danger-color);
            text-align: center;
            margin-top: 15px;
        }
        .success-message {
            color: var(--success-color);
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">緊急シフト追加</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/admin_home.jsp" class="icon" title="管理者ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <div class="form-container">
                <h2>新しい緊急シフトを追加</h2>
                <form action="${pageContext.request.contextPath}/admin/addUrgentShiftExecute" method="post">
                    <div class="form-group">
                        <label for="shiftDate">日付:</label>
                        <input type="date" id="shiftDate" name="shiftDate" required>
                    </div>
                    <div class="form-group">
                        <label for="startTime">開始時間:</label>
                        <input type="time" id="startTime" name="startTime" required>
                    </div>
                    <div class="form-group">
                        <label for="endTime">終了時間:</label>
                        <input type="time" id="endTime" name="endTime" required>
                    </div>
                    <div class="form-group">
                        <label for="deptId">部署:</label>
                        <select id="deptId" name="deptId" required>
                            <% 
                                List<DepartmentBean> departments = null;
                                try (Connection conn = DBConnection.getConnection()) {
                                    DepartmentDAO deptDAO = new DepartmentDAO(conn);
                                    departments = deptDAO.getAllDepartments();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                    // Handle error, maybe set an error message
                                } 
                                if (departments != null) {
                                    for (DepartmentBean dept : departments) {
                            %>
                                        <option value="<%= dept.getDeptId() %>"><%= dept.getDeptName() %></option>
                            <%      }
                                } else {
                            %>
                                    <option value="">部署を読み込めませんでした</option>
                            <%  }
                            %>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="submit">追加</button>
                    </div>
                </form>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                <% if (request.getAttribute("success") != null) { %>
                    <div class="success-message">
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>