<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, bean.SubmissionPeriodBean" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト提出期間の選択</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .period-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .period-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            text-decoration: none;
            color: inherit;
            display: block;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .period-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .period-card.overdue {
            background-color: #f8f9fa; /* Light gray */
            pointer-events: none; /* Not clickable */
            opacity: 0.6;
        }
        .period-label {
            font-size: 1.2em;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .deadline-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9em;
        }
        .deadline-label {
            color: #dc3545; /* Red */
        }
        .remaining-days {
            font-weight: bold;
            color: #007bff; /* Blue */
        }
        .overdue .deadline-label, .overdue .remaining-days {
            color: #6c757d; /* Muted gray */
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">シフト提出</div>
        </header>

        <main>
            <div class="period-list">
                <% 
                    List<SubmissionPeriodBean> periods = (List<SubmissionPeriodBean>) request.getAttribute("submissionPeriods");
                    if (periods != null && !periods.isEmpty()) {
                        for (SubmissionPeriodBean period : periods) {
                            String cardClass = period.isOverdue() ? "period-card overdue" : "period-card";
                %>    
                            <a href="${pageContext.request.contextPath}/shift/EnterShiftsAction?startDate=<%= period.getPeriodStartDate() %>&endDate=<%= period.getPeriodEndDate() %>" class="<%= cardClass %>">
                                <div class="period-label"><%= period.getPeriodLabel() %></div>
                                <div class="deadline-info">
                                    <span class="deadline-label"><%= period.getDeadlineLabel() %></span>
                                    <% if (period.isOverdue()) { %>
                                        <span class="remaining-days">受付終了</span>
                                    <% } else { %>
                                        <span class="remaining-days">残り <%= period.getRemainingDays() %> 日</span>
                                    <% } %>
                                </div>
                            </a>
                <% 
                        }
                    } else {
                %>
                    <p>現在、受付可能なシフト提出期間はありません。</p>
                <% } %>
            </div>
        </main>

        <%@ include file="../menu/menu.jsp" %>
    </div>
</body>
</html>