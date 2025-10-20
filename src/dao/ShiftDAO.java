package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.ShiftBean;
import util.DBConnection;

public class ShiftDAO {

    public List<ShiftBean> getShiftsByUser(int userId) {
        List<ShiftBean> shifts = new ArrayList<>();
        String sql = "SELECT * FROM shift WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ShiftBean shift = new ShiftBean();
                shift.setShiftId(rs.getInt("shift_id"));
                shift.setUserId(rs.getInt("user_id"));
                shift.setShiftDate(rs.getDate("shift_date"));
                shift.setStartTime(rs.getString("start_time"));
                shift.setEndTime(rs.getString("end_time"));
                shift.setConfirmed(rs.getBoolean("confirmed"));
                shift.setSubmitted(rs.getBoolean("submitted"));
                shifts.add(shift);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shifts;
    }
}
