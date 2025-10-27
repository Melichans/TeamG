package shift;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.SubmissionPeriodBean;

@WebServlet("/shift/AddShiftAction")
public class AddShiftAction extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SubmissionPeriodBean> periods = new ArrayList<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter periodFormatter = DateTimeFormatter.ofPattern("M/d(E)", Locale.JAPANESE);
        DateTimeFormatter deadlineFormatter = DateTimeFormatter.ofPattern("M/d(E) HH:mm", Locale.JAPANESE);

        LocalDate currentPeriodStart = today.withDayOfMonth(1);

        // Loop until we find 6 available periods
        while (periods.size() < 6) {
            LocalDate periodStart, periodEnd, deadlineDate;

            if (currentPeriodStart.getDayOfMonth() == 1) {
                periodStart = currentPeriodStart;
                periodEnd = periodStart.withDayOfMonth(15);
                deadlineDate = periodStart.minusMonths(1).withDayOfMonth(10);
            } else { // Day is 16
                periodStart = currentPeriodStart;
                periodEnd = periodStart.with(TemporalAdjusters.lastDayOfMonth());
                deadlineDate = periodStart.minusMonths(1).withDayOfMonth(20);
            }

            LocalDateTime deadline = deadlineDate.atTime(23, 59);
            LocalDateTime now = LocalDateTime.now();

            // Only add the period to the list if its deadline has not passed
            if (!now.isAfter(deadline)) {
                SubmissionPeriodBean period = new SubmissionPeriodBean();
                period.setPeriodStartDate(periodStart);
                period.setPeriodEndDate(periodEnd);
                period.setPeriodLabel(String.format("%s~%s", periodStart.format(periodFormatter), periodEnd.format(periodFormatter)));
                period.setDeadlineLabel("締切: " + deadline.format(deadlineFormatter));
                
                long remainingDays = ChronoUnit.DAYS.between(now.toLocalDate(), deadline.toLocalDate());
                period.setRemainingDays(remainingDays);
                period.setOverdue(false);

                periods.add(period);
            }

            // Always move to the next period start date for the next iteration
            if (currentPeriodStart.getDayOfMonth() == 1) {
                currentPeriodStart = currentPeriodStart.withDayOfMonth(16);
            } else {
                currentPeriodStart = currentPeriodStart.plusMonths(1).withDayOfMonth(1);
            }
        }
        
        request.setAttribute("submissionPeriods", periods);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/addshift/addshift.jsp");
        dispatcher.forward(request, response);
    }
}