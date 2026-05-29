package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        String cd = request.getParameter("cd");

        Subject subject = new Subject();
        subject.setCd(cd);

        SubjectDAO dao = new SubjectDAO();
        // 削除実行
        dao.delete(subject, teacher.getSchool_cd());

        // 完了画面へ
        request.getRequestDispatcher("subject_delete_done.jsp").forward(request, response);
    }
}
