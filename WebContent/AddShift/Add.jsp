<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト登録</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/AddShift/style.css">
</head>
<body>
<div class="container">
    <h1>シフト登録</h1>

    <form action="<%= request.getContextPath() %>/shift/AddShiftExecuteAction" method="post">
        <input type="hidden" name="userId" value="1">
        <div class="form-group">
            <label for="userName">名前：</label>
            <input type="text" id="userName" name="userName" required>
        </div>       

        <div class="form-group">
            <label for="shiftDate">日にち：</label>
            <input type="date" id="shiftDate" name="shiftDate" required>
        </div>

        <div class="form-group">
            <label for="startTime">開始時間：</label>
            <input type="time" id="startTime" name="startTime" required>
        </div>

        <div class="form-group">
            <label for="endTime">終了時間：</label>
            <input type="time" id="endTime" name="endTime" required>
        </div>

        <div class="buttons">
            <button type="submit">登録</button>
            <button type="reset">リセット</button>
        </div>
    </form>

    <% if (request.getAttribute("message") != null) { %>
        <p class="message"><%= request.getAttribute("message") %></p>
    <% } %>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/shift/ShiftListAction">シフト一覧へ</a>
        <a href="<%= request.getContextPath() %>/menu.jsp">メニューへ戻る</a>
    </div>
</div>
</body>
</html>
