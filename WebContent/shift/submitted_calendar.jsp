<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.NoticeBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ホーム</title>
<link rel="stylesheet" href="../home/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
    .shift-dot {
        width: 5px;
        height: 5px;
        background-color: gray;
        border-radius: 50%;
        position: absolute;
        bottom: 5px;
        left: 50%;
        transform: translateX(-50%);
    }
    td.has-shift {
        position: relative;
        cursor: pointer;
    }
    .shift-info {
        display: none; /* Initially hidden */
    }
    td.selected-day {
        border: 2px solid #007bff !important;
        border-radius: 50%;
    }
    td.is-today {
        font-weight: bold;
        color: #0d6efd;
    }
</style>
</head>
<body>

<div class="container">

    <header>
        <div class="header-icons">
            <a href="#" class="icon"><i class="fa-solid fa-calendar-days"></i></a>
            <a href="#" class="icon"><i class="fa-solid fa-users"></i></a>
        </div>
        <div class="calendar-nav">
            <button id="prev-month" class="nav-btn"><i class="fa-solid fa-chevron-left"></i></button>
            <div id="calendar-title" class="title"></div>
            <button id="next-month" class="nav-btn"><i class="fa-solid fa-chevron-right"></i></button>
        </div>
        <div class="header-icons">
            <a href="#" class="icon"><i class="fa-solid fa-clipboard-list"></i></a>
        </div>
    </header>

    <main>
        <section class="actions">
            <button class="btn btn-checked"><i class="fa-solid fa-check"></i> 確認済み</button>
            <button class="btn btn-submitted"><i class="fa-solid fa-file-arrow-up"></i> 提出済み</button>
        </section>

        <section class="calendar">
            <table>
                <thead>
                    <tr><th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th></tr>
                </thead>
                <tbody id="calendar-body">
                </tbody>
            </table>
        </section>

        <section class="shift-info" id="shift-info-section">
            <div class="date" id="shift-info-date"></div>
            <div id="shift-details-container"></div>
            <div class="attendance-status">
                <h3 class="status-title">現在出勤状況 <span class="live-indicator"></span></h3>
                <ul class="worker-list">
                    <li>田中</li>
                    <li>村本</li>
                    <li>佐々木</li>
                </ul>
            </div>
        </section>
    </main>

    <section class="submit-shift-section" style="padding: 0 20px 20px 20px;">
        <button onclick="location.href='${pageContext.request.contextPath}/shift/AddShiftAction'" class="btn btn-primary" style="width: 100%; padding: 15px; font-size: 1.1em;"><i class="fa-solid fa-plus"></i> シフト提出</button>
    </section>

    <%@ include file="../menu/menu.jsp" %>

</div>

<script>
let currentDisplayedDate = new Date();
const realToday = new Date();
let monthShifts = [];

async function fetchSubmittedShifts(year, month) {
    try {
        // Call the new action to get only submitted shifts
        const response = await fetch(`<%= request.getContextPath() %>/shift/getSubmittedShifts?year=${year}&month=${month}`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        monthShifts = await response.json();
        // DEBUG: Show the raw data received from the server
        alert("Debug Data Received: " + JSON.stringify(monthShifts));
    } catch (error) {
        // DEBUG: Show the error if the fetch fails
        alert("Error fetching data: " + error);
        monthShifts = [];
    }
}

function renderCalendar(year, month) {
    const calendarBody = document.getElementById('calendar-body');
    const calendarTitle = document.getElementById('calendar-title');
    
    calendarTitle.textContent = year + '年' + (month + 1) + '月';
    calendarBody.innerHTML = '';

    const firstDayOfMonth = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    
    // Create a set of dates that have a submitted shift for quick lookup
    const submittedShiftDates = new Set();
    monthShifts.forEach(s => {
        if (s.status === '提出済み') {
            submittedShiftDates.add(new Date(s.shiftDate.replace(/-/g, '/')).getDate());
        }
    });

    let date = 1;
    for (let i = 0; i < 6; i++) {
        let row = document.createElement('tr');
        for (let j = 0; j < 7; j++) {
            let cell = document.createElement('td');
            if (i === 0 && j < firstDayOfMonth) {
                // Empty cell
            } else if (date > daysInMonth) {
                // Empty cell
            } else {
                cell.textContent = date;
                
                // In this view, we don't need the click handler to show details
                // cell.addEventListener('click', ...);

                // Add a grey dot if the date has a submitted shift
                if (submittedShiftDates.has(date)) {
                    cell.classList.add('has-shift');
                    const dot = document.createElement('div');
                    dot.className = 'shift-dot';
                    cell.appendChild(dot);
                }

                if (date === realToday.getDate() && month === realToday.getMonth() && year === realToday.getFullYear()) {
                    cell.classList.add('is-today');
                }
                date++;
            }
            row.appendChild(cell);
        }
        calendarBody.appendChild(row);
        if (date > daysInMonth) {
            break;
        }
    }
    // Hide the shift details section in this view
    document.getElementById('shift-info-section').style.display = 'none';
}

async function updateCalendar() {
    const year = currentDisplayedDate.getFullYear();
    const month = currentDisplayedDate.getMonth();
    await fetchSubmittedShifts(year, month);
    renderCalendar(year, month);
}

function setupCalendarNavigation() {
    document.getElementById('prev-month').addEventListener('click', () => {
        currentDisplayedDate.setMonth(currentDisplayedDate.getMonth() - 1);
        updateCalendar();
    });

    document.getElementById('next-month').addEventListener('click', () => {
        currentDisplayedDate.setMonth(currentDisplayedDate.getMonth() + 1);
        updateCalendar();
    });
}

document.addEventListener('DOMContentLoaded', () => {
    updateCalendar();
    setupCalendarNavigation();
});
</script>
</body>
</html>