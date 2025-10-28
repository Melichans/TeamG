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
                        <span class="staff-phone"><a href="tel:${s.phone.replace(/-/g, '')}">${s.phone}</a></span>
                    </li>
                `;
            });
        } else {
            staffHtml += '<p>現在勤務中のスタッフはいません。</p>';
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
