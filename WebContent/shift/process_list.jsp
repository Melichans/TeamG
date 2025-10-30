<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>処理一覧</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .menu-list {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        .menu-list li a {
            display: flex;
            align-items: center;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-decoration: none;
            color: #333;
            font-size: 1.1em;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .menu-list li a:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .menu-list i {
            font-size: 24px;
            margin-right: 20px;
            color: #007bff;
            width: 30px; /* Align icons */
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">処理一覧</div>
        </header>

        <main>
            <ul class="menu-list">
                <li>
                    <a href="${pageContext.request.contextPath}/shift/ListForConfirmationAction">
                        <i class="fa-solid fa-check-to-slot"></i>
                        <span>シフト確認</span>
                    </a>
                </li>
                <!-- Other items can be added here in the future -->
            </ul>
        </main>

        <%@ include file="/menu/menu.jsp" %>
    </div>
</body>
</html>
