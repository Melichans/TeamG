package shift;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;

import bean.ShiftBean;
import bean.UserBean;
import dao.ShiftDAO;

@WebServlet("/shift/getShiftsForMonth")
public class GetShiftsForMonthAction extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /** コネクションプールからコネクションを取得 */
    private Connection getConnection() throws NamingException, java.sql.SQLException {
        InitialContext ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TeamG");
        return ds.getConnection();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // 🧩 ログインチェック
            HttpSession session = request.getSession(false);
            UserBean user = (session != null) ? (UserBean) session.getAttribute("user") : null;

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"error\":\"User not logged in\"}");
                return;
            }

            // 🧮 パラメータチェック
            String yearParam = request.getParameter("year");
            String monthParam = request.getParameter("month");

            if (yearParam == null || monthParam == null || yearParam.isEmpty() || monthParam.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Year and month parameters are required\"}");
                return;
            }

            int year = Integer.parseInt(yearParam);
            int month = Integer.parseInt(monthParam) + 1; // JSのmonthは0始まり

            // 🧠 DAOを呼び出し
            try (Connection conn = getConnection()) {
                ShiftDAO dao = new ShiftDAO(conn);
                List<ShiftBean> shifts = dao.getShiftsByMonth(user.getUserId(), year, month);

                JSONArray jsonArr = new JSONArray();
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

                for (ShiftBean s : shifts) {
                    JSONObject obj = new JSONObject();
                    obj.put("shiftDate", s.getShiftDate() != null ? s.getShiftDate().toString() : "");
                    obj.put("startTime", (s.getStartTime() != null) ? timeFormat.format(s.getStartTime()) : "");
                    obj.put("endTime", (s.getEndTime() != null) ? timeFormat.format(s.getEndTime()) : "");
                    obj.put("status", (s.getStatus() != null) ? s.getStatus() : "");
                    obj.put("deptName", (s.getDeptName() != null) ? s.getDeptName() : "");
                    jsonArr.put(obj);
                }
                for (ShiftBean s : shifts) {
                    System.out.println("DEBUG: " +
                        "shift_date=" + s.getShiftDate() +
                        ", start=" + s.getStartTime() +
                        ", end=" + s.getEndTime() +
                        ", dept=" + s.getDeptName() +
                        ", status=" + s.getStatus());
                }

                out.print(jsonArr.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\":\"Internal Server Error\"}");
        }
    }
}
