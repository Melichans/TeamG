package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.ShiftBean;

public class ShiftDAO {
    private Connection conn;

    public ShiftDAO(Connection conn) {
        this.conn = conn;
    }

    // 📅 特定の月のシフトリストを取得します
    public List<ShiftBean> getShiftsByMonth(int userId, int year, int month) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();

        String sql = """
            SELECT s.shift_date, s.start_time, s.end_time, s.status, d.dept_name
            FROM shift s
            JOIN department d ON s.dept_id = d.dept_id
            WHERE s.user_id = ?
              AND YEAR(s.shift_date) = ?
              AND MONTH(s.shift_date) = ?
            ORDER BY s.shift_date ASC
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, year);
            ps.setInt(3, month);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setDeptName(rs.getString("dept_name"));
                    list.add(s);
                }
            }
        }
        return list;
    }
}
