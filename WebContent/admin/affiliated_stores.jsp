<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>系列店一覧 - リアルタイム状況</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/home/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .company-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 30px;
        }
        .company-item {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 15px;
            font-size: 1.1em;
            font-weight: bold;
            color: #343a40;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .company-item:hover {
            background-color: #e2e6ea;
            border-color: #dae0e5;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }
        .company-item.selected {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .working-staff-section {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .working-staff-section h3 {
            margin-top: 0;
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .staff-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .staff-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .staff-item:last-child { border-bottom: none; }
        .staff-name {
            font-weight: bold;
            color: #343a40;
        }
        .staff-phone a {
            color: #007bff;
            text-decoration: none;
        }
        .staff-phone a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="title">系列店リアルタイム状況</div>
            <div class="header-icons">
                <a href="<%= request.getContextPath() %>/home/admin_home.jsp" class="icon" title="管理者ホーム"><i class="fa-solid fa-house"></i></a>
            </div>
        </header>

        <main>
            <section class="company-list">
                <div class="company-item" data-company-id="1">Company A</div>
                <div class="company-item" data-company-id="2">Company B</div>
                <div class="company-item" data-company-id="3">Company C</div>
            </section>

            <section class="working-staff-section" id="working-staff-display">
                <h3>現在勤務中のスタッフ (Company A)</h3>
                <ul class="staff-list">
                    <li class="staff-item">
                        <span class="staff-name">田中 太郎</span>
                        <span class="staff-phone"><a href="tel:09012345678">090-1234-5678</a></span>
                    </li>
                    <li class="staff-item">
                        <span class="staff-name">鈴木 花子</span>
                        <span class="staff-phone"><a href="tel:08098765432">080-9876-5432</a></span>
                    </li>
                    <li class="staff-item">
                        <span class="staff-name">佐藤 健</span>
                        <span class="staff-phone"><a href="tel:07011223344">070-1122-3344</a></span>
                    </li>
                </ul>
            </section>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const companyItems = document.querySelectorAll('.company-item');
            const staffDisplay = document.getElementById('working-staff-display');

            // Mock data for demonstration
            const mockStaffData = {
                1: {
                    name: "Company A",
                    staff: [
                        { name: "田中 太郎", phone: "090-1234-5678" },
                        { name: "鈴木 花子", phone: "080-9876-5432" },
                        { name: "佐藤 健", phone: "070-1122-3344" }
                    ]
                },
                2: {
                    name: "Company B",
                    staff: [
                        { name: "山田 次郎", phone: "090-5555-1111" },
                        { name: "高橋 美咲", phone: "080-4444-2222" }
                    ]
                },
                3: {
                    name: "Company C",
                    staff: [
                        { name: "小林 幸子", phone: "090-3333-7777" }
                    ]
                }
            };

            function renderStaff(companyId) {
                console.log("renderStaff called for companyId:", companyId);
                const data = mockStaffData[companyId];
                if (!data) {
                    staffDisplay.innerHTML = '<h3>現在勤務中のスタッフ (選択なし)</h3><p>スタッフ情報がありません。</p>';
                    console.log("No data for companyId:", companyId);
                    return;
                }

                let staffHtml = `<h3>現在勤務中のスタッフ (${data.name})</h3><ul class="staff-list">`;
                if (data.staff.length > 0) {
                    data.staff.forEach(s => {
                        staffHtml += `
                            <li class="staff-item">
                                <span class="staff-name">${s.name}</span>
                                <span class="staff-phone"><a href="tel:\${s.phone.replace(/-/g, \'\')}\">${s.phone}</a></span>
                            </li>
                        `;
                    });
                } else {
                    staffHtml += \'<p>現在勤務中のスタッフはいません。</p>\';
                }
                staffHtml += '</ul>';
                console.log("Generated staffHtml:", staffHtml);
                staffDisplay.innerHTML = staffHtml;
            }

            companyItems.forEach(item => {
                item.addEventListener('click', function() {
                    console.log("Company item clicked:", this.textContent);
                    companyItems.forEach(ci => ci.classList.remove('selected'));
                    this.classList.add('selected');
                    const companyId = this.dataset.companyId;
                    renderStaff(companyId);
                });
            });

            // Initial render for Company A
            if (companyItems.length > 0) {
                companyItems[0].click(); // Simulate click on the first company
            }
        });
    </script>
</body>
</html>