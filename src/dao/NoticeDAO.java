package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.NoticeBean;
import util.DBConnection;

public class NoticeDAO {

    public List<NoticeBean> getAllNotices() {
        List<NoticeBean> list = new ArrayList<>();
        String sql = "SELECT * FROM notice ORDER BY notice_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                NoticeBean notice = new NoticeBean();
                notice.setNoticeId(rs.getInt("notice_id"));
                notice.setTitle(rs.getString("title"));
                notice.setMessage(rs.getString("message"));
                notice.setNoticeDate(rs.getTimestamp("notice_date")); // Use getTimestamp for TIMESTAMP
                notice.setIsRead(rs.getBoolean("is_read"));
                list.add(notice);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addNotice(NoticeBean notice) throws SQLException {
        String sql = "INSERT INTO notice (title, message, notice_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, notice.getTitle());
            ps.setString(2, notice.getMessage());
            ps.setTimestamp(3, new java.sql.Timestamp(notice.getNoticeDate().getTime()));
            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    notice.setNoticeId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public void markAllAsRead() {
        String sql = "UPDATE notice SET is_read = TRUE WHERE is_read = FALSE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<NoticeBean> getRecentNotices(int limit) {
        List<NoticeBean> list = new ArrayList<>();
        String sql = "SELECT * FROM notice ORDER BY notice_date DESC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NoticeBean notice = new NoticeBean();
                    notice.setNoticeId(rs.getInt("notice_id"));
                    notice.setTitle(rs.getString("title"));
                    notice.setMessage(rs.getString("message"));
                    notice.setNoticeDate(rs.getTimestamp("notice_date"));
                    notice.setIsRead(rs.getBoolean("is_read"));
                    list.add(notice);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
