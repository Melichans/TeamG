package shift;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shift/ShiftListAction")
public class ShiftListAction extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 一覧データを取得するサーブレットに処理を渡す
        RequestDispatcher dispatcher = request.getRequestDispatcher("/shift/ShiftListExecuteAction");
        dispatcher.forward(request, response);
    }
}
