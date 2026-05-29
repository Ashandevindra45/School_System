package subject;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 1. パラメータの取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");

        // 2. 更新用データの作成
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);

        // 3. DBへ科目を保存
        SubjectDAO dao = new SubjectDAO();
        dao.save(subject, teacher.getSchool_cd());

        // 4. 【修正】完了画面へ絶対パスでフォワード（大文字小文字を正確に指定）
        request.getRequestDispatcher("/subject/SubjectUpdateDone.jsp").forward(request, response);
    }
}
