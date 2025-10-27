<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, bean.ShiftEntryDayBean, java.time.format.DateTimeFormatter" %>
<%@ page import="bean.ShiftBean" %>
<%@ page import="bean.DepartmentBean" %>
<%@ page import="java.util.List, java.util.Map" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト入力</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* === Main List Styles === */
        .day-list {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 10px;
        }
        .day-row {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .day-row:last-child { border-bottom: none; }
        .day-row:hover { background-color: #f8f9fa; }
        .day-label { font-size: 1.1em; font-weight: bold; }
        .saturday { color: #007bff; }
        .sunday { color: #dc3545; }
        .weekday { color: #343a40; }

        /* === Modal Styles === */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1000; 
            left: 0; top: 0;
            width: 100%; height: 100%;
            overflow: auto; 
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 25px;
            border: 1px solid #888;
            width: 90%;
            max-width: 500px;
            border-radius: 8px;
            position: relative;
        }
        .close-btn {
            color: #aaa;
            position: absolute;
            top: 10px; right: 20px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 5px; }
        .form-group select, .form-group textarea {
            width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;
        }
        .work-preference-group {
            display: flex; gap: 10px;
        }
        .work-preference-group label {
            flex: 1; padding: 10px; border: 2px solid #ddd; 
            border-radius: 4px; text-align: center; cursor: pointer;
        }
        .work-preference-group input[type="radio"] { display: none; }
        .work-preference-group input[type="radio"]:checked + label {
            background-color: #e9f5ff;
            border-color: #007bff;
            color: #007bff;
            font-weight: bold;
        }
        .time-select-group { display: flex; align-items: center; gap: 10px; }
        #modal-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        #modal-actions button { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        #btn-save { background-color: #007bff; color: white; font-size: 1.1em; flex-grow: 2;}
        #btn-clear { background-color: #6c757d; color: white; }

    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">シフト入力 [<%= request.getAttribute("periodLabel") %>]</div>
        </header>

        <main>
    <div class="day-list">
        <%
            List<Map<String, Object>> dayList = (List<Map<String, Object>>) request.getAttribute("dayList");
            if (dayList != null && !dayList.isEmpty()) {
                String startDate = (String) request.getAttribute("periodStartDate");
                String endDate = (String) request.getAttribute("periodEndDate");
        %>

        <% for (Map<String, Object> day : dayList) { 
                String dateStr = (String) day.get("date");
                String label = (String) day.get("label");
                boolean hasShift = (boolean) day.get("hasShift");
        %>
            <div class="day-row"
                 style="<%= hasShift ? "background-color:#e6f3ff; border-left:4px solid #007bff;" : "" %>">
                <a href="<%= request.getContextPath() %>/shift/EditDayAction?date=<%= dateStr %>&periodStartDate=<%= startDate %>&periodEndDate=<%= endDate %>"
                   class="day-link">
                    <span class="day-label"><%= label %></span>
                    <% if (hasShift) { %>
                        <span class="saved-shift-info" 
                              style="color:#007bff; font-size:0.9em; margin-left:10px;">✅ 保存済み</span>
                    <% } %>
                </a>
            </div>
        <% } %>

        <% } else { %>
            <p>シフト入力期間の日付が見つかりません。</p>
        <% } %>
    </div>
</main>


        <%@ include file="../menu/menu.jsp" %>
    </div>

    <!-- The Modal -->
    <div id="shiftModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeShiftModal()">&times;</span>
            
            <div class="form-group">
                <label>勤務日</label>
                <p id="modalWorkDate" style="font-size: 1.2em; font-weight: bold;"></p>
            </div>

            <div class="form-group">
                <label for="modalStore">勤務店舗</label>
                <select id="modalStore">
                     <% 
                        List<DepartmentBean> departments = (List<DepartmentBean>) request.getAttribute("departments");
                        if (departments != null) {
                            for (DepartmentBean dept : departments) {
                    %>    
                                <option value="<%= dept.getDeptId() %>"><%= dept.getDeptName() %></option>
                    <% 
                            }
                        }
                    %> 
                </select>
            </div>

            <div class="form-group">
                <label>勤務希望</label>
                <div class="work-preference-group">
                    <input type="radio" id="pref_work" name="work_preference" value="work" checked>
                    <label for="pref_work">勤務</label>
                    <input type="radio" id="pref_rest" name="work_preference" value="rest">
                    <label for="pref_rest">休み</label>
                </div>
            </div>
            
            <div class="form-group">
                <label>希望勤務時間</label>
                <div class="time-select-group">
                    <select id="modalStartTimeHour">
                        <% for(int h=7; h<=23; h++) { %><option value="<%= String.format("%02d", h) %>"><%= h %></option><% } %>
                    </select>
                    <span>:</span>
                    <select id="modalStartTimeMinute">
                        <% for(int m=0; m<60; m+=5) { %><option value="<%= String.format("%02d", m) %>"><%= String.format("%02d", m) %></option><% } %>
                    </select>
                    <span>~</span>
                    <select id="modalEndTimeHour">
                        <% for(int h=7; h<=23; h++) { %><option value="<%= String.format("%02d", h) %>"><%= h %></option><% } %>
                    </select>
                    <span>:</span>
                    <select id="modalEndTimeMinute">
                        <% for(int m=0; m<60; m+=5) { %><option value="<%= String.format("%02d", m) %>"><%= String.format("%02d", m) %></option><% } %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="modalMemo">メモ</label>
                <textarea id="modalMemo" rows="3"></textarea>
            </div>

            <div id="modal-actions">
                <button id="btn-clear" onclick="clearShiftInputs()">入力クリア</button>
                <button id="btn-save">保存</button>
            </div>
        </div>
    </div>

    <script>
    const modal = document.getElementById('shiftModal');
    const modalWorkDate = document.getElementById('modalWorkDate');

    function openShiftModal(date, dayOfWeek) {
        // Format date for display
        const parts = date.split('-');
        modalWorkDate.textContent = `\${parseInt(parts[1])}/\${parseInt(parts[2])} ${dayOfWeek}`;
        // You can store the raw date `_` in a data attribute if needed for saving
        modal.dataset.rawDate = date; 
        modal.style.display = "block";
    }

    function closeShiftModal() {
        modal.style.display = "none";
    }

    function clearShiftInputs() {
        document.getElementById('modalStore').selectedIndex = 0;
        document.getElementById('pref_work').checked = true;
        document.getElementById('modalStartTimeHour').selectedIndex = 0;
        document.getElementById('modalStartTimeMinute').selectedIndex = 0;
        document.getElementById('modalEndTimeHour').selectedIndex = 0;
        document.getElementById('modalEndTimeMinute').selectedIndex = 0;
        document.getElementById('modalMemo').value = '';
    }

    // Close modal if user clicks outside of the modal content
    window.onclick = function(event) {
        if (event.target == modal) {
            closeShiftModal();
        }
    }
    
    // --- TODO: Save button logic --- 
    // For now, it just closes the modal.
    document.getElementById('btn-save').onclick = function() {
        console.log('Save button clicked. Data would be saved here.');
        // In the future, you would collect all input values here and send to a servlet.
        closeShiftModal();
    }
</script>

</body>
</html>