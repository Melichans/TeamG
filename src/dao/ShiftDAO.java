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

    public void addUserShift(ShiftBean shift) throws SQLException {
        String sql = "INSERT INTO `shift` (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (?, ?, ?, ?, ?, '提出済み')";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, shift.getUserId());
            ps.setInt(2, shift.getDeptId());
            ps.setDate(3, new java.sql.Date(shift.getShiftDate().getTime()));
            ps.setTime(4, shift.getStartTime());
            ps.setTime(5, shift.getEndTime());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.addUserShift エラー: " + e.getMessage(), e);
        }
    }

    /**
     * 管理者が募集中のシフトを追加
     * @param shift 追加するシフト情報
     * @throws SQLException
     */
    public void addOpenShift(ShiftBean shift) throws SQLException {
        // Explicitly set user_id to NULL as it's an open shift everyone can apply to
        String sql = "INSERT INTO `shift` (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setNull(1, java.sql.Types.INTEGER); // user_id is NULL for open shifts
            ps.setInt(2, shift.getDeptId());
            ps.setDate(3, shift.getShiftDate());
            ps.setTime(4, shift.getStartTime());
            ps.setTime(5, shift.getEndTime());
            ps.setString(6, shift.getStatus()); // Should be '募集' for open shifts
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.addOpenShift エラー: " + e.getMessage(), e);
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
                     "WHERE s.status = '募集' AND s.shift_date >= CURDATE() " +  // ← chỉ lọc trạng thái & ngày
                     "ORDER BY s.shift_date ASC, s.start_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
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


    public List<ShiftBean> getShiftsByStatus(String status) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();
        String sql = "SELECT s.shift_id, s.user_id, u.name as user_name, s.dept_id, d.dept_name, s.shift_date, s.start_time, s.end_time, s.status " +
                     "FROM `shift` s " +
                     "JOIN `user` u ON s.user_id = u.user_id " +
                     "JOIN `department` d ON s.dept_id = d.dept_id " +
                     "WHERE s.status = ? " +
                     "ORDER BY s.shift_date ASC, s.start_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setUserName(rs.getString("user_name"));
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setDeptName(rs.getString("dept_name"));
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.getShiftsByStatus エラー: " + e.getMessage(), e);
        }
        return list;
    }

    public List<ShiftBean> getShiftsByStatusForUser(int userId, String status) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();
        // This query is similar to getShiftsByStatus but also filters by user_id
        String sql = "SELECT s.shift_id, s.user_id, u.name as user_name, s.dept_id, d.dept_name, s.shift_date, s.start_time, s.end_time, s.status " +
                     "FROM `shift` s " +
                     "JOIN `user` u ON s.user_id = u.user_id " +
                     "JOIN `department` d ON s.dept_id = d.dept_id " +
                     "WHERE s.user_id = ? AND s.status = ? " +
                     "ORDER BY s.shift_date ASC, s.start_time ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setUserName(rs.getString("user_name"));
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setDeptName(rs.getString("dept_name"));
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.getShiftsByStatusForUser エラー: " + e.getMessage(), e);
        }
        return list;
    }

    public List<ShiftBean> getShiftsForUserBetweenDates(int userId, java.time.LocalDate periodStartDate, java.time.LocalDate periodEndDate) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();
        String sql = "SELECT s.shift_id, s.user_id, s.dept_id, d.dept_name, s.shift_date, s.start_time, s.end_time, s.status, s.memo " +
                     "FROM `shift` s " +
                     "LEFT JOIN `department` d ON s.dept_id = d.dept_id " +
                     "WHERE s.user_id = ? AND s.shift_date BETWEEN ? AND ? " +
                     "ORDER BY s.shift_date ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(periodStartDate));
            ps.setDate(3, java.sql.Date.valueOf(periodEndDate));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setDeptName(rs.getString("dept_name"));
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setMemo(rs.getString("memo"));
                    list.add(s);
                }
            }
        }
        return list;
    }

    public void deleteUserShift(int userId, java.sql.Date shiftDate) throws SQLException {
        String sql = "DELETE FROM `shift` WHERE user_id = ? AND shift_date = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, shiftDate);
            ps.executeUpdate();
        }
    }

    public void saveOrUpdateUserShift(ShiftBean shift) throws SQLException {
        // Check if a shift already exists for this user and date
        String checkSql = "SELECT shift_id FROM `shift` WHERE user_id = ? AND shift_date = ?";
        int existingShiftId = -1;

        try (PreparedStatement checkPs = conn.prepareStatement(checkSql)) {
            checkPs.setInt(1, shift.getUserId());
            checkPs.setDate(2, shift.getShiftDate());
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    existingShiftId = rs.getInt("shift_id");
                }
            }
        }

        if (existingShiftId != -1) {
            // Update existing shift
            String updateSql = "UPDATE `shift` SET dept_id = ?, start_time = ?, end_time = ?, status = ?, memo = ? WHERE shift_id = ?";
            try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                updatePs.setInt(1, shift.getDeptId());
                updatePs.setTime(2, shift.getStartTime());
                updatePs.setTime(3, shift.getEndTime());
                updatePs.setString(4, shift.getStatus());
                updatePs.setString(5, shift.getMemo());
                updatePs.setInt(6, existingShiftId);
                updatePs.executeUpdate();
            }
        } else {
            // Insert new shift
            String insertSql = "INSERT INTO `shift` (user_id, dept_id, shift_date, start_time, end_time, status, memo) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                insertPs.setInt(1, shift.getUserId());
                insertPs.setInt(2, shift.getDeptId());
                insertPs.setDate(3, shift.getShiftDate());
                insertPs.setTime(4, shift.getStartTime());
                insertPs.setTime(5, shift.getEndTime());
                insertPs.setString(6, shift.getStatus());
                insertPs.setString(7, shift.getMemo());
                insertPs.executeUpdate();
            }
        }
    }

    public List<ShiftBean> getShiftsByMonthAndStatus(int userId, int year, int month, String status) throws SQLException {
        List<ShiftBean> list = new ArrayList<>();
        String sql = "SELECT s.shift_id, s.user_id, s.dept_id, d.dept_name, s.shift_date, s.start_time, s.end_time, s.status, s.memo " +
                     "FROM `shift` s " +
                     "LEFT JOIN `department` d ON s.dept_id = d.dept_id " +
                     "WHERE s.user_id = ? AND YEAR(s.shift_date) = ? AND MONTH(s.shift_date) = ? AND s.status = ? " +
                     "ORDER BY s.shift_date ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, year);
            ps.setInt(3, month);
            ps.setString(4, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftBean s = new ShiftBean();
                    s.setShiftId(rs.getInt("shift_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setDeptId(rs.getInt("dept_id"));
                    s.setDeptName(rs.getString("dept_name")); // Add this line
                    s.setShiftDate(rs.getDate("shift_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setStatus(rs.getString("status"));
                    s.setMemo(rs.getString("memo"));
                    list.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.getShiftsByMonthAndStatus エラー: " + e.getMessage(), e);
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

    public void updateShiftStatus(int shiftId, String newStatus) throws SQLException {
        String sql = "UPDATE `shift` SET status = ? WHERE shift_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, shiftId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.updateShiftStatus エラー: " + e.getMessage(), e);
        }
    }

    public void revertSubmittedShiftsToDrafts(int userId, java.time.LocalDate startDate, java.time.LocalDate endDate) throws SQLException {
        String sql = "UPDATE `shift` SET status = '下書き' WHERE user_id = ? AND status = '提出済み' AND shift_date BETWEEN ? AND ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(startDate));
            ps.setDate(3, java.sql.Date.valueOf(endDate));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.revertSubmittedShiftsToDrafts エラー: " + e.getMessage(), e);
        }
    }


    public void submitDraftsForPeriod(int userId, java.time.LocalDate startDate, java.time.LocalDate endDate) throws SQLException {
        // Use a transaction to ensure both operations succeed or fail together
        conn.setAutoCommit(false);
        try {
            // 1. Delete any previously submitted shifts for this user and period
            String deleteSql = "DELETE FROM `shift` WHERE user_id = ? AND status = '提出済み' AND shift_date BETWEEN ? AND ?";
            try (PreparedStatement deletePs = conn.prepareStatement(deleteSql)) {
                deletePs.setInt(1, userId);
                deletePs.setDate(2, java.sql.Date.valueOf(startDate));
                deletePs.setDate(3, java.sql.Date.valueOf(endDate));
                deletePs.executeUpdate();
            }

            // 2. Update all draft shifts for this user and period to 'submitted'
            String updateSql = "UPDATE `shift` SET status = '提出済み' WHERE user_id = ? AND status = '下書き' AND shift_date BETWEEN ? AND ?";
            try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                updatePs.setInt(1, userId);
                updatePs.setDate(2, java.sql.Date.valueOf(startDate));
                updatePs.setDate(3, java.sql.Date.valueOf(endDate));
                updatePs.executeUpdate();
            }

            // If both operations are successful, commit the transaction
            conn.commit();

        } catch (SQLException e) {
            // If any error occurs, roll back the transaction
            conn.rollback();
            e.printStackTrace();
            throw new SQLException("ShiftDAO.submitDraftsForPeriod エラー: " + e.getMessage(), e);
        } finally {
            // Restore default auto-commit behavior
            conn.setAutoCommit(true);
        }
    }

    public void updateStatusForMultipleShifts(String[] shiftIds, String newStatus) throws SQLException {
        if (shiftIds == null || shiftIds.length == 0) {
            return; // Nothing to update
        }

        // Build the SQL with placeholders for the IN clause
        StringBuilder sql = new StringBuilder("UPDATE `shift` SET status = ? WHERE shift_id IN (");
        for (int i = 0; i < shiftIds.length; i++) {
            sql.append("?");
            if (i < shiftIds.length - 1) {
                sql.append(",");
            }
        }
        sql.append(")");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            // Set the new status
            ps.setString(1, newStatus);

            // Set the shift IDs
            for (int i = 0; i < shiftIds.length; i++) {
                ps.setInt(i + 2, Integer.parseInt(shiftIds[i]));
            }

            ps.executeUpdate();
        } catch (NumberFormatException e) {
            throw new SQLException("Invalid shift ID format.", e);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("ShiftDAO.updateStatusForMultipleShifts エラー: " + e.getMessage(), e);
        }
    }
}
