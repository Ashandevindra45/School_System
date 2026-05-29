package subject;

import java.util.HashMap;
import java.util.Map;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false); // セッションを取得
        
        // --- 修正箇所: ログインチェックを追加 ---
        if (session == null || session.getAttribute("teacher") == null) {
            // ログインしていない場合はログイン画面へリダイレクト
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // パラメータの取得
        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        
        SubjectDAO dao = new SubjectDAO();
        Map<String, String> errors = new HashMap<>();

        // バリデーション
        if (cd == null || cd.length() != 3) {
            errors.put("cd", "科目コードは3文字で入力してください");
        }

        if (errors.isEmpty()) {
            // ここで teacher.getSchool_cd() を使う（チェック済みなので安全）
            Subject existing = dao.get(cd, teacher.getSchool_cd());
            if (existing != null) {
                errors.put("cd", "科目コードが重複しています");
            }
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            request.getRequestDispatcher("subject_create.jsp").forward(request, response);
            return;
        }

        // 保存処理
        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        dao.save(subject, teacher.getSchool_cd());

        request.getRequestDispatcher("subject_create_done.jsp").forward(request, response);
    }
}
