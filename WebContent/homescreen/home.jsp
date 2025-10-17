<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>AIシフト ホーム</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <!-- ===== Header (icons + title) ===== -->
    <div class="header">
        <div class="left-icons">
            <span class="icon calendar">📅</span>
            <span class="icon people">👥</span>
        </div>
        <div class="month-title">
            <span class="year">2025</span><span class="month">9</span>
        </div>
        <div class="right-icons">
            <span class="icon alert">🧾</span>
        </div>
    </div>

    <!-- ===== Legend: 確認済み / 提出済み ===== -->
    <div class="legend">
        <div class="legend-item confirmed">確認済み</div>
        <div class="legend-item submitted">提出済み</div>
    </div>

    <!-- ===== カレンダー ===== -->
    <div class="calendar">
        <table class="calendar-table">
            <thead>
                <tr>
                    <th>日</th><th>月</th><th>火</th><th>水</th><th>木</th><th>金</th><th>土</th>
                </tr>
            </thead>
            <tbody>
                <tr><td></td><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td></tr>
                <tr><td>7</td><td>8</td><td>9</td><td class="selected">10</td><td>11</td><td>12</td><td>13</td></tr>
                <tr><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td><td>19</td><td>20</td></tr>
                <tr><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td><td>26</td><td>27</td></tr>
                <tr><td>28</td><td>29</td><td>30</td><td></td><td></td><td></td><td></td></tr>
            </tbody>
        </table>
    </div>

    <!-- ===== 詳細 ===== -->
    <div class="shift-detail">
        <p class="date">9月10日(木曜日)</p>
        <p class="time">✅ 11:00 ～ 16:00</p>
        <p class="location">🍳 キッチン</p>

        <div class="status">
            <p class="status-title">現在出勤状況</p>
            <ul>
                <li>田中</li>
                <li>村本</li>
                <li>佐々木</li>
            </ul>
        </div>

        <button class="shift-button">＋シフト設定</button>
    </div>

    <!-- ===== Navigation ===== -->
    <div class="nav-bar">
        <button>シフト</button>
        <button>処理一覧</button>
        <button>通知</button>
        <button>マイページ</button>
    </div>
</div>

</body>
</html>
//asd