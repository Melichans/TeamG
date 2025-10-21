package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
                notice.setNoticeDate(rs.getDate("notice_date"));
                list.add(notice);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
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

}
