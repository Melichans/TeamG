<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, bean.DepartmentBean" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>シフト詳細入力</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; }
        .form-group select, .form-group textarea {
            width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;
        }
        .work-preference-group {
            display: flex; gap: 10px;
        }
        .work-preference-group label {
            flex: 1; padding: 12px; border: 2px solid #ddd; 
            border-radius: 4px; text-align: center; cursor: pointer; font-size: 16px;
        }
        .work-preference-group input[type="radio"] { display: none; }
        .work-preference-group input[type="radio"]:checked + label {
            background-color: #e9f5ff;
            border-color: #007bff;
            color: #007bff;
            font-weight: bold;
        }
        .time-select-group { display: flex; align-items: center; gap: 10px; }
        .form-actions { display: flex; justify-content: flex-end; gap: 15px; margin-top: 25px; }
        .form-actions button { padding: 12px 25px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        #btn-save { background-color: #007bff; color: white; font-weight: bold; order: 2; flex-grow: 1; max-width: 200px;}
        #btn-clear { background-color: #6c757d; color: white; order: 1;}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">シフト詳細入力</div>
        </header>

        <main>
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/shift/SaveShiftDetailsAction" method="post">
                    <input type="hidden" name="rawDate" value="<%= request.getAttribute("rawDate") %>">
                    <input type="hidden" name="periodStartDate" value="<%= request.getAttribute("periodStartDate") %>">
                    <input type="hidden" name="periodEndDate" value="<%= request.getAttribute("periodEndDate") %>">

                    <div class="form-group">
                        <label>勤務日</label>
                        <p style="font-size: 1.3em; font-weight: bold; color: #333;"><%= request.getAttribute("displayDate") %></p>
                    </div>

                    <div class="form-group" id="position-group">
                        <label for="store">勤務ポジション</label>
                        <select id="store" name="deptId">
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
                    
                    <div class="form-group" id="time-group">
                        <label>希望勤務時間</label>
                        <div class="time-select-group">
                            <select name="startTimeHour">
                                <% for(int h=7; h<=23; h++) { %><option value="<%= String.format("%02d", h) %>"><%= h %></option><% } %>
                            </select>
                            <span>:</span>
                            <select name="startTimeMinute">
                                <% for(int m=0; m<60; m+=5) { %><option value="<%= String.format("%02d", m) %>"><%= String.format("%02d", m) %></option><% } %>
                            </select>
                            <span>~</span>
                            <select name="endTimeHour">
                                <% for(int h=7; h<=23; h++) { %><option value="<%= String.format("%02d", h) %>"><%= h %></option><% } %>
                            </select>
                            <span>:</span>
                            <select name="endTimeMinute">
                                <% for(int m=0; m<60; m+=5) { %><option value="<%= String.format("%02d", m) %>"><%= String.format("%02d", m) %></option><% } %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="memo">メモ</label>
                        <textarea id="memo" name="memo" rows="4"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="reset" id="btn-clear">入力クリア</button>
                        <button type="submit" id="btn-save">保存</button>
                    </div>
                </form>
            </div>
        </main>

        <%@ include file="../menu/menu.jsp" %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const prefWork = document.getElementById('pref_work');
            const prefRest = document.getElementById('pref_rest');
            
            const positionGroup = document.getElementById('position-group');
            const timeGroup = document.getElementById('time-group');

            function toggleWorkFields() {
                if (prefRest.checked) {
                    positionGroup.style.display = 'none';
                    timeGroup.style.display = 'none';
                } else {
                    positionGroup.style.display = 'block';
                    timeGroup.style.display = 'block';
                }
            }

            // Add event listeners
            prefWork.addEventListener('change', toggleWorkFields);
            prefRest.addEventListener('change', toggleWorkFields);

            // Initial check on page load
            toggleWorkFields();
        });
    </script>
</body>
</html>
