package shift;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shift/SubmittedCalendarAction")
public class SubmittedCalendarAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This action simply forwards to the JSP page that will render the calendar.
        RequestDispatcher dispatcher = request.getRequestDispatcher("/shift/submitted_calendar.jsp");
        dispatcher.forward(request, response);
    }
}
