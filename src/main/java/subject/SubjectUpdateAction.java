package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 1. 変更対象の科目コードをリクエストパラメータから取得
        String cd = request.getParameter("cd");

        // 2. DBから科目の詳細データを取得
        SubjectDAO dao = new SubjectDAO();
        Subject subject = dao.get(cd, teacher.getSchool_cd());

        // 3. 取得したデータをリクエストにセットして変更画面へ
        request.setAttribute("subject", subject);
        request.getRequestDispatcher("subject_update.jsp").forward(request, response);
    }
}
