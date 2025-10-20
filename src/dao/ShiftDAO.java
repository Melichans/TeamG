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

    public void addShift(ShiftBean shift) throws SQLException {
        String sql = "INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shift.getUserId());
            ps.setInt(2, shift.getDeptId());
            ps.setDate(3, shift.getShiftDate());
            ps.setTime(4, shift.getStartTime());
            ps.setTime(5, shift.getEndTime());
            ps.setString(6, shift.getStatus());
            ps.setTimestamp(7, shift.getCreatedAt());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Lỗi thêm ca làm việc: " + e.getMessage(), e);
        }
    }

    public List<ShiftBean> getShiftsByUser(int userId) throws SQLException {
        List<ShiftBean> shifts = new ArrayList<>();
        String sql = "SELECT shift_id, user_id, dept_id, shift_date, start_time, end_time, status, created_at, approved_by " +
                     "FROM shift WHERE user_id = ? ORDER BY shift_date";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ShiftBean shift = new ShiftBean();
                shift.setShiftId(rs.getInt("shift_id"));
                shift.setUserId(rs.getInt("user_id"));
                shift.setDeptId(rs.getInt("dept_id"));
                shift.setShiftDate(rs.getDate("shift_date"));
                shift.setStartTime(rs.getTime("start_time"));
                shift.setEndTime(rs.getTime("end_time"));
                shift.setStatus(rs.getString("status"));
                shift.setCreatedAt(rs.getTimestamp("created_at"));
                shift.setApprovedBy(rs.getInt("approved_by") == 0 ? null : rs.getInt("approved_by"));
                shifts.add(shift);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi lấy danh sách ca làm việc: " + e.getMessage(), e);
        }
        return shifts;
    }
}