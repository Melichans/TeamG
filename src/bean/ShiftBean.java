package bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class ShiftBean {
    private int shiftId;
    private int userId;
    private int deptId;
    private Date shiftDate;
    private Time startTime;
    private Time endTime;
    private String status;
    private Timestamp createdAt;
    private Integer approvedBy;

    public int getShiftId() { return shiftId; }
    public void setShiftId(int shiftId) { this.shiftId = shiftId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }

    public Date getShiftDate() { return shiftDate; }
    public void setShiftDate(Date shiftDate) { this.shiftDate = shiftDate; }

    public Time getStartTime() { return startTime; }
    public void setStartTime(Time startTime) { this.startTime = startTime; }

    public Time getEndTime() { return endTime; }
    public void setEndTime(Time endTime) { this.endTime = endTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Integer getApprovedBy() { return approvedBy; }
    public void setApprovedBy(Integer approvedBy) { this.approvedBy = approvedBy; }
}