<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.NoticeBean" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>お知らせ</title>
    <link rel="stylesheet" href="../home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .notice-item {
            background-color: var(--white);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 15px;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .notice-item.unread {
            border-left: 5px solid var(--primary-color);
        }
        .notice-item h3 {
            margin-top: 0;
            margin-bottom: 5px;
            color: var(--dark-color);
        }
        .notice-item p {
            font-size: 14px;
            color: var(--text-color);
            margin-bottom: 5px;
        }
        .notice-item .date {
            font-size: 12px;
            color: #888;
            text-align: right;
        }
        .header-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .header-buttons .menu-button, .header-buttons .mark-read {
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.2s ease;
        }
        .header-buttons .menu-button {
            background-color: #6c757d;
            color: white;
        }
        .header-buttons .menu-button:hover {
            background-color: #5a6268;
        }
        .header-buttons .mark-read {
            background-color: var(--primary-color);
            color: white;
            border: none;
            cursor: pointer;
        }
        .header-buttons .mark-read:hover {
            background-color: #308acb;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">お知らせ</div>
            <div class="header-icons">
                <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="icon" title="ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <div class="header-buttons">
                <a href="${pageContext.request.contextPath}/menu/menu.jsp" class="menu-button">メインメニューへ</a>
                <form action="${pageContext.request.contextPath}/noticafition/markAllRead" method="post" style="display:inline;">
                    <button type="submit" class="mark-read">全て既読</button>
                </form>
            </div>
            <div class="notice-list">
                <% 
                    List<NoticeBean> noticeList = (List<NoticeBean>) request.getAttribute("noticeList");
                    if (noticeList != null && !noticeList.isEmpty()) {
                        for (NoticeBean notice : noticeList) {
                %>
                            <div class="notice-item <%=(!notice.getIsRead() ? "unread" : "")%>">
                                <h3><%= notice.getTitle() %></h3>
                                <p><%= notice.getMessage() %></p>
                                <p class="date"><%= notice.getNoticeDate() %></p>
                            </div>
                <% 
                        }
                    } else {
                %>
                        <div class="notice-box">
                            お知らせはありません。
                        </div>
                <% 
                    }
                %>
            </div>
        </main>

<%@ include file="../menu/menu.jsp" %>
    </div>
</body>
</html>
