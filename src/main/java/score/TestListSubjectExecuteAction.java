package score;

import java.util.List;

import bean.Teacher;
import bean.Test;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. セッションチェック
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            // ログインしていない場合はログイン画面へ強制リダイレクト
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("teacher");
        String schoolCd = teacher.getSchool_cd();

        // 2. パラメータの取得
        String f1 = request.getParameter("f1"); // 年度
        String f2 = request.getParameter("f2"); // クラス
        String f3 = request.getParameter("f3"); // 科目

        // 3. 検索実行
        TestDAO dao = new TestDAO();
        // すべての引数が揃っているか確認してから検索
        if (f1 != null && f2 != null && f3 != null && !f1.equals("0")) {
            List<Test> tests = dao.filter(Integer.parseInt(f1), f2, f3, schoolCd);
            request.setAttribute("tests", tests);
        }

        // 選択値を維持するために属性にセット
        request.setAttribute("f1", f1);
        request.setAttribute("f2", f2);
        request.setAttribute("f3", f3);

        // 4. 結果画面へフォワード
        request.getRequestDispatcher("test_list_subject.jsp").forward(request, response);
    }
}
