<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, java.util.Map, bean.ShiftBean, java.text.SimpleDateFormat" %>

<%! 
    // SimpleDateFormat is not thread-safe, but for this JSP-level usage, it's acceptable.
    // For production in a servlet, you'd use a thread-safe approach.
    private final SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm"); 
%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト入力</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Override for a contained, full-width menu */
        footer .navbar {
            width: 100%; /* Match the container width */
            margin: 20px 0 0; /* Top margin only */
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-top: 1px solid #ddd;
            position: static;
            box-sizing: border-box; /* Ensure padding/border are included in width */
        }

        /* New layout styles */
        .day-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            gap: 10px; /* Space between status and button */
        }
        .day-status {
            width: 200px; /* Fixed width for alignment */
            text-align: center;
            font-weight: bold;
            font-size: 0.95em;
        }
        .day-action-link {
            flex-grow: 1; /* Takes up remaining space */
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            padding: 18px 15px; 
            text-decoration: none; 
            color: #333; 
            border: 1px solid #e0e0e0;
            border-radius: 5px; 
            background-color: #fff; 
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            transition: all 0.2s ease;
        }
        .day-action-link:hover {
            border-color: #007bff;
            background-color: #f8f9fa;
            transform: translateY(-1px);
        }
        .input-label {
            display: flex;
            align-items: center;
            color: #007bff;
            font-weight: bold;
        }
        .input-label span { margin-right: 8px; }

        /* Original styles for list content */
        .day-list { list-style: none; padding: 0; }
        .day-item { margin-bottom: 8px; }
        .day-item a {
            display: flex; justify-content: space-between; align-items: center; 
            padding: 18px 15px; text-decoration: none; color: #333; 
            border-bottom: 1px solid #f0f0f0; border-radius: 5px; 
            background-color: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .day-label { font-size: 1.1em; font-weight: 500; display: flex; align-items: center; }
        .day-label .date { margin-right: 10px; }
        .shift-info { display: flex; align-items: center; font-size: 0.95em; }
        .saved-shift-time { color: #28a745; font-weight: 600; margin-right: 15px; }
        .no-shift { color: #6c757d; font-style: italic; }
        .arrow-icon { color: #ccc; font-size: 1.2em; }
        .info-text { text-align: center; color: #6c757d; padding: 40px; }
        .day-of-week.saturday { color: #007bff; }
        .day-of-week.sunday { color: #dc3545; }

        .finalize-submission {
            text-align: center;
            margin-top: 30px;
            padding-bottom: 20px;
        }
        .btn-submit-finalize {
            display: inline-block;
            padding: 12px 30px;
            background-color: #28a745; /* Green */
            color: white;
            font-size: 1.1em;
            font-weight: bold;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s;
        }
        .btn-submit-finalize:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            String periodLabel = (String) request.getAttribute("periodLabel");
            if (periodLabel == null) periodLabel = ""; 
        %>
        <header>
            <div class="title">シフト入力 [<%= periodLabel %>]</div>
        </header>

        <main>
            <%-- Error display for debugging --%>
            <% String detailedError = (String) request.getAttribute("detailedError");
               if (detailedError != null) { %>
                 <div style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
                   <p style="margin:0;"><b>デバッグ情報 (Debug Info):</b> <%= detailedError %></p>
                 </div>
            <% } %>

            <% 
                List<Map<String, Object>> dayList = (List<Map<String, Object>>) request.getAttribute("dayList");
                if (dayList != null && !dayList.isEmpty()) {
                    String startDate = (String) request.getAttribute("periodStartDate");
                    String endDate = (String) request.getAttribute("periodEndDate");
            %>
            <ul class="day-list">
                <% for (Map<String, Object> day : dayList) { 
                        String dateStr = (String) day.get("date");
                        String label = (String) day.get("label");
                        ShiftBean shift = (ShiftBean) day.get("shift");

                        String dayOfWeek = label.substring(label.indexOf("(") + 1, label.indexOf(")"));
                        String dayClass = "";
                        if ("土".equals(dayOfWeek)) dayClass = "saturday";
                        if ("日".equals(dayOfWeek)) dayClass = "sunday";
                %>
                <li class="day-item">
                    <%-- Status on the left --%>
                    <div class="day-status">
                        <% if (shift != null && shift.getStartTime() != null && shift.getEndTime() != null) { %>
                            <span class="saved-shift-time">
                                <i class="fa-regular fa-clock"></i> 
                                <%= timeFormatter.format(shift.getStartTime()) %> ~ <%= timeFormatter.format(shift.getEndTime()) %>
                            </span>
                        <% } else { %>
                            <span class="no-shift">休み</span>
                        <% } %>
                    </div>

                    <%-- Action button on the right --%>
                    <a href="<%= request.getContextPath() %>/shift/EditDayAction?date=<%= dateStr %>&periodStartDate=<%= startDate %>&periodEndDate=<%= endDate %>" class="day-action-link">
                        <div class="day-label">
                            <span class="date"><%= label.substring(0, label.indexOf("(")) %></span>
                            <span class="day-of-week <%= dayClass %>">(<%= dayOfWeek %>)</span>
                        </div>
                        <div class="input-label">
                            <span>入力</span>
                            <i class="fas fa-chevron-right arrow-icon"></i>
                        </div>
                    </a>
                </li>
                <% } %>
            </ul>
            <% } else { %>
                <p class="info-text">シフト入力期間の日付が見つかりません。</p>
            <% } %>

            <div class="finalize-submission">
                <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="btn-submit-finalize">シフト提出を完了する</a>
            </div>
        </main>

        <%@ include file="/menu/menu.jsp" %>
    </div>
</body>
</html>