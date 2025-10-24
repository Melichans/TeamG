<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, bean.ShiftBean" %>

<%
    List<ShiftBean> shiftList = (List<ShiftBean>) request.getAttribute("shiftList");

    int year = request.getParameter("year") != null ? Integer.parseInt(request.getParameter("year")) : Calendar.getInstance().get(Calendar.YEAR);
    int month = request.getParameter("month") != null ? Integer.parseInt(request.getParameter("month")) : Calendar.getInstance().get(Calendar.MONTH) + 1;

    Calendar calendar = Calendar.getInstance();
    calendar.set(year, month - 1, 1);
    int startDay = calendar.get(Calendar.DAY_OF_WEEK);
    int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

    int prevYear = (month == 1) ? year - 1 : year;
    int prevMonth = (month == 1) ? 12 : month - 1;
    int nextYear = (month == 12) ? year + 1 : year;
    int nextMonth = (month == 12) ? 1 : month + 1;
%>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>シフト一覧（カレンダー表示）</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <h2><%= year %>年 <%= month %>月 のシフト一覧</h2>

  <div class="month-nav">
    <button onclick="location.href='ShiftListAction?year=<%=prevYear%>&month=<%=prevMonth%>'">← 前月</button>
    <button onclick="location.href='ShiftListAction?year=<%=nextYear%>&month=<%=nextMonth%>'">翌月 →</button>
  </div>

  <div class="nav-buttons">
    <button onclick="location.href='<%=request.getContextPath()%>/home/user_home.jsp'">🏠 ホームへ</button>
    <button onclick="location.href='<%=request.getContextPath()%>/shift/AutoShiftAction'">⚙️ シフト自動生成</button>
    <button onclick="location.href='<%=request.getContextPath()%>/menu.jsp'">📋 メニューへ</button>
  </div>

  <table class="calendar">
    <thead>
      <tr>
        <th style="color:red;">日</th>
        <th>月</th>
        <th>火</th>
        <th>水</th>
        <th>木</th>
        <th>金</th>
        <th style="color:blue;">土</th>
      </tr>
    </thead>
    <tbody>
      <%
        int dayCounter = 1;
        for (int week = 0; week < 6; week++) {
          out.print("<tr>");
          for (int day = 1; day <= 7; day++) {
            if (week == 0 && day < startDay || dayCounter > lastDay) {
              out.print("<td></td>");
            } else {
              String dateString = String.format("%04d-%02d-%02d", year, month, dayCounter);
      %>
              <td onclick="showDetail('<%=dateString%>')" class="calendar-cell">
                <div class='day-number'><%= dayCounter %></div>
                <%
                  if (shiftList != null) {
                    for (ShiftBean shift : shiftList) {
                      if (shift.getShiftDate() != null && shift.getShiftDate().toString().equals(dateString)) {
                        out.print("<div class='shift-entry'>");
                        out.print(shift.getStartTime() + "〜" + shift.getEndTime());
                        out.print("<br>" + shift.getDeptName());
                        out.print("</div>");
                      }
                    }
                  }
                %>
              </td>
      <%
              dayCounter++;
            }
          }
          out.print("</tr>");
          if (dayCounter > lastDay) break;
        }
      %>
    </tbody>
  </table>

  <div id="detailModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal()">&times;</span>
      <h3 id="modalTitle"></h3>
      <div id="modalBody">読み込み中...</div>
    </div>
  </div>

  <script>
    function showDetail(date) {
      const modal = document.getElementById("detailModal");
      const title = document.getElementById("modalTitle");
      const body = document.getElementById("modalBody");

      title.textContent = date + " のシフト詳細";

      body.innerHTML = "この日のシフト情報を読み込み中...";
    
      fetch("<%=request.getContextPath()%>/shift/ShiftDetailAction?date=" + date)
        .then(response => response.text())
        .then(data => { body.innerHTML = data; })
        .catch(() => { body.innerHTML = "データ取得エラー"; });

      modal.style.display = "block";
    }

    function closeModal() {
      document.getElementById("detailModal").style.display = "none";
    }

    window.onclick = function(event) {
      const modal = document.getElementById("detailModal");
      if (event.target === modal) {
        modal.style.display = "none";
      }
    }
  </script>
</body>
</html>
