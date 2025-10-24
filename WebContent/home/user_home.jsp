<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.NoticeBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ホーム</title>
<link rel="stylesheet" href="css/style.css">
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
            <button class="btn btn-primary btn-add-shift"><i class="fa-solid fa-plus"></i> シフト設定</button>
        </section>
    </main>

    <footer>
        <nav>
            <a href="${pageContext.request.contextPath}/home/user_home.jsp" class="nav-item active"><i class="fa-solid fa-calendar-alt"></i><span>シフト</span></a>
            <a href="${pageContext.request.contextPath}/shift_manager/open_shifts.jsp" class="nav-item"><i class="fa-solid fa-list-check"></i><span>処理一覧</span></a>
            <a href="${pageContext.request.contextPath}/noticafition/noticeList" class="nav-item"><i class="fa-solid fa-bell"></i><span>通知</span></a>
            <a href="${pageContext.request.contextPath}/mypage/my_page.jsp" class="nav-item active"><i class="fa-solid fa-user"></i><span>マイページ</span></a>
        </nav>
    </footer>

</div>

<script>
let currentDisplayedDate = new Date();
const realToday = new Date();
let monthShifts = [];
let selectedCell = null;

async function fetchShiftsForMonth(year, month) {
    try {
        const response = await fetch("<%= request.getContextPath() %>/shift/getShiftsForMonth?year=" + year + "&month=" + month);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        monthShifts = await response.json();
        console.log("DEBUG monthShifts:", monthShifts);
    } catch (error) {
        console.error("Could not fetch shifts:", error);
        monthShifts = [];
    }
}

function renderCalendar(year, month) {
    const calendarBody = document.getElementById('calendar-body');
    const calendarTitle = document.getElementById('calendar-title');
    
    calendarTitle.textContent = year + '年' + (month + 1) + '月';
    calendarBody.innerHTML = '';
    // Do not null out selectedCell here to persist selection across month navigations

    const firstDayOfMonth = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    
    const shiftDates = monthShifts.map(s => new Date(s.shiftDate.replace(/-/g, '/')).getDate());

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
                
                const currentYear = year;
                const currentMonth = month;
                const currentDate = date;

                cell.addEventListener('click', () => {
                    if (selectedCell) {
                        selectedCell.classList.remove('selected-day');
                    }
                    cell.classList.add('selected-day');
                    selectedCell = cell;
                    displayShiftInfo(currentYear, currentMonth, currentDate);
                });

                if (shiftDates.includes(date)) {
                    cell.classList.add('has-shift');
                    const dot = document.createElement('div');
                    dot.className = 'shift-dot';
                    cell.appendChild(dot);
                }

                // Handle today's date
                if (date === realToday.getDate() && month === realToday.getMonth() && year === realToday.getFullYear()) {
                    cell.classList.add('is-today'); // Style for today's text
                    // Set initial selection to today
                    if (selectedCell === null) { // Only on first load
                        cell.classList.add('selected-day');
                        selectedCell = cell;
                    }
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
}

function displayShiftInfo(year, month, day) {
    const dateStr = year + '-' + String(month + 1).padStart(2, '0') + '-' + String(day).padStart(2, '0');
    const shiftsForDay = monthShifts.filter(s => s.shiftDate === dateStr);
    const infoSection = document.getElementById('shift-info-section');
    const dateDisplay = document.getElementById('shift-info-date');
    const detailsContainer = document.getElementById('shift-details-container');

    dateDisplay.textContent = (month + 1) + '月' + day + '日';

    if (shiftsForDay.length > 0) {
        detailsContainer.innerHTML = '';
        shiftsForDay.forEach(shift => {
            const shiftDiv = document.createElement('div');
            shiftDiv.className = 'shift-details';

            // Directly display what the backend sends.
            const startTime = shift.startTime;
            const endTime = shift.endTime;

            shiftDiv.innerHTML = `
                <p class="time"><i class="fa-regular fa-clock"></i> 
                    \${shift.startTime ? shift.startTime : "未設定"} ～ \${shift.endTime ? shift.endTime : "未設定"}
                </p>
                <p class="section"><i class="fa-solid fa-utensils"></i> 
                    \${shift.deptName && shift.deptName !== "false" ? shift.deptName : "未設定"}
                </p>
            `;



            detailsContainer.appendChild(shiftDiv);
        });
    } else {
        detailsContainer.innerHTML = '<p>本日、シフトはありません。</p>';
    }
    infoSection.style.display = 'block';
}

async function updateCalendar() {
    const year = currentDisplayedDate.getFullYear();
    const month = currentDisplayedDate.getMonth();
    await fetchShiftsForMonth(year, month);
    renderCalendar(year, month);

    // After rendering, if a day is selected, show its info.
    if (selectedCell) {
        const day = parseInt(selectedCell.textContent);
        const month = currentDisplayedDate.getMonth();
        const year = currentDisplayedDate.getFullYear();
        displayShiftInfo(year, month, day);
    } else {
        document.getElementById('shift-info-section').style.display = 'none'; 
    }
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