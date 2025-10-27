package bean;

import java.time.LocalDate;

public class SubmissionPeriodBean {

    private String periodLabel;
    private String deadlineLabel;
    private long remainingDays;
    private LocalDate periodStartDate;
    private LocalDate periodEndDate;
    private boolean isOverdue;

    public String getPeriodLabel() {
        return periodLabel;
    }

    public void setPeriodLabel(String periodLabel) {
        this.periodLabel = periodLabel;
    }

    public String getDeadlineLabel() {
        return deadlineLabel;
    }

    public void setDeadlineLabel(String deadlineLabel) {
        this.deadlineLabel = deadlineLabel;
    }

    public long getRemainingDays() {
        return remainingDays;
    }

    public void setRemainingDays(long remainingDays) {
        this.remainingDays = remainingDays;
    }

    public LocalDate getPeriodStartDate() {
        return periodStartDate;
    }

    public void setPeriodStartDate(LocalDate periodStartDate) {
        this.periodStartDate = periodStartDate;
    }

    public LocalDate getPeriodEndDate() {
        return periodEndDate;
    }

    public void setPeriodEndDate(LocalDate periodEndDate) {
        this.periodEndDate = periodEndDate;
    }

    public boolean isOverdue() {
        return isOverdue;
    }

    public void setOverdue(boolean isOverdue) {
        this.isOverdue = isOverdue;
    }
}
