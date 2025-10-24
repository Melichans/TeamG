package shift;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

    /** コネクションプール（JNDI）からコネクションを取得します */
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

        PrintWriter out = response.getWriter();
        
        try {
            // 🧩 ログインチェック
            HttpSession session = request.getSession(false);
            UserBean user = (session != null) ? (UserBean) session.getAttribute("user") : null;

            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.print("{\"error\":\"User not logged in\"}");
                return;
            }

            String yearParam = request.getParameter("year");
            String monthParam = request.getParameter("month");

            if (yearParam == null || yearParam.isEmpty() || monthParam == null || monthParam.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"error\":\"Year and month parameters are required and cannot be empty\"}");
                return;
            }

            int year = Integer.parseInt(yearParam);
            int month = Integer.parseInt(monthParam) + 1; // JavaScriptの月は0から始まるため

            // 🧠 DAOを呼び出してデータを取得
            try (Connection conn = getConnection()) {
                ShiftDAO dao = new ShiftDAO(conn);
                List<ShiftBean> shifts = dao.getShiftsByMonth(user.getUserId(), year, month);

                // 🧱 JSONに変換
                JSONArray jsonArr = new JSONArray();
                for (ShiftBean s : shifts) {
                    JSONObject obj = new JSONObject();
                    obj.put("shiftDate", s.getShiftDate().toString());
                    obj.put("startTime", s.getStartTime().toString().substring(0, 5));
                    obj.put("endTime", s.getEndTime().toString().substring(0, 5));
                    obj.put("status", s.getStatus());
                    obj.put("deptName", s.getDeptName());
                    jsonArr.put(obj);
                }

                out.print(jsonArr.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Server error\"}");
        }
    }
}
