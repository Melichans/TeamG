<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>お知らせ追加 - SSAI</title>
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
        .form-group input[type="text"],
        .form-group textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
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
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">お知らせ追加</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/admin_home.jsp" class="icon" title="管理者ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <div class="form-container">
                <h2>新しいお知らせを追加</h2>
                <form action="${pageContext.request.contextPath}/admin/addNoticeExecute" method="post">
                    <div class="form-group">
                        <label for="title">タイトル:</label>
                        <input type="text" id="title" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="message">メッセージ:</label>
                        <textarea id="message" name="message" required></textarea>
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
                    <div class="success-message" style="color: var(--success-color); text-align: center; margin-top: 15px;">
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>