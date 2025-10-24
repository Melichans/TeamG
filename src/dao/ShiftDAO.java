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

    /**
     * 特定の月のシフトデータを取得
     * @param userId ユーザーID
     * @param year 年
     * @param month 月
     * @return シフトリスト
     * @throws SQLException
     */
    public List<ShiftBean> getShiftsByMonth(int userId, int year, int month) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();

        String sql = "SELECT "
                   + "s.shift_id, "
                   + "s.user_id, "
                   + "s.dept_id, "
                   + "s.shift_date, "
                   + "s.start_time, "
                   + "s.end_time, "
                   + "s.status, "
                   + "d.dept_name "
                   + "FROM shift s "
                   + "LEFT JOIN department d ON s.dept_id = d.dept_id "
                   + "WHERE s.user_id = ? "
                   + "AND YEAR(s.shift_date) = ? "
                   + "AND MONTH(s.shift_date) = ? "
                   + "ORDER BY s.shift_date ASC, s.start_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, year);
            ps.setInt(3, month);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setDeptName(rs.getString("dept_name"));

                    // 🔍 Debug log
                    System.out.println("[DEBUG][ShiftDAO] shift_date=" + s.getShiftDate()
                            + ", start=" + s.getStartTime()
                            + ", end=" + s.getEndTime()
                            + ", dept=" + s.getDeptName()
                            + ", status=" + s.getStatus());

                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.getShiftsByMonth エラー: " + e.getMessage(), e);
        }

        return list;
    }

    /**
     * 新しいシフトを追加
     * @param shift 追加するシフト情報
     * @throws SQLException
     */
    public void addShift(ShiftBean shift) throws SQLException {
        String sql = "INSERT INTO `shift` (dept_id, shift_date, start_time, end_time, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shift.getDeptId());
            ps.setDate(2, shift.getShiftDate());
            ps.setTime(3, shift.getStartTime());
            ps.setTime(4, shift.getEndTime());
            ps.setString(5, shift.getStatus()); // Should be '募集' for open shifts
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.addShift エラー: " + e.getMessage(), e);
        }
    }

    /**
     * 募集中のシフトリストを取得
     * @return 募集中のシフトリスト
     * @throws SQLException
     */
    public List<ShiftBean> getOpenShifts() throws SQLException {
        List<ShiftBean> list = new ArrayList<>();
        String sql = "SELECT s.shift_id, s.user_id, s.dept_id, s.shift_date, s.start_time, s.end_time, s.status, d.dept_name " +
                     "FROM `shift` s " +
                     "LEFT JOIN department d ON s.dept_id = d.dept_id " +
                     "WHERE s.user_id IS NULL AND s.status = '募集' " +
                     "ORDER BY s.shift_date ASC, s.start_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    // user_id will be null for open shifts, so we don't set it here
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setDeptName(rs.getString("dept_name"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.getOpenShifts エラー: " + e.getMessage(), e);
        }
        return list;
    }

    /**
     * 募集中のシフトにユーザーを割り当てる
     * @param shiftId シフトID
     * @param userId 割り当てるユーザーID
     * @return 更新された行数
     * @throws SQLException
     */
    public int applyForShift(int shiftId, int userId) throws SQLException {
        String sql = "UPDATE `shift` SET user_id = ?, status = '提出済み' WHERE shift_id = ? AND user_id IS NULL AND status = '募集'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, shiftId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.applyForShift エラー: " + e.getMessage(), e);
        }
    }
}
