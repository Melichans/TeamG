package bean;

import java.util.Date;

public class NoticeBean {
    private int noticeId;
    private String title;
    private String message;
    private Date noticeDate;

    public int getNoticeId() { return noticeId; }
    public void setNoticeId(int noticeId) { this.noticeId = noticeId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public Date getNoticeDate() { return noticeDate; }
    public void setNoticeDate(Date noticeDate) { this.noticeDate = noticeDate; }
}
