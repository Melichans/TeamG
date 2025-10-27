package shift;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shift/EditDayAction")
public class EditDayAction extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get the date from the request
            String dateStr = request.getParameter("date");
            System.out.println("[DEBUG EditDayAction] Received dateStr: " + dateStr);
            LocalDate date = LocalDate.parse(dateStr);
            System.out.println("[DEBUG EditDayAction] Parsed date: " + date);

            // Format it for display
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("M/d(E)", Locale.JAPANESE);
            request.setAttribute("displayDate", date.format(dateFormatter));
            request.setAttribute("rawDate", date.toString()); // Pass the raw date for the form
         // Lấy dữ liệu từ request (hoặc gán tạm thời nếu chưa có)
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            // Nếu null thì gán giá trị mặc định để tránh lỗi null
            if (startDateStr == null) startDateStr = "";
            if (endDateStr == null) endDateStr = "";

            // Truyền sang JSP
            request.setAttribute("periodStartDate", startDateStr);
            request.setAttribute("periodEndDate", endDateStr);
            

            // Fetch departments for the dropdown
            try (Connection conn = util.DBConnection.getConnection()) {
                dao.DepartmentDAO deptDAO = new dao.DepartmentDAO(conn);
                request.setAttribute("departments", deptDAO.getAllDepartments());
            } catch (java.sql.SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "部署リストの取得中にエラーが発生しました。" + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "日付の処理中にエラーが発生しました。" + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/addshift/edit_day.jsp");
        dispatcher.forward(request, response);
    }
}
