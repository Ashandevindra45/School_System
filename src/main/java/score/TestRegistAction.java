package score;

import java.util.ArrayList;
import java.util.List;

import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        String schoolCd = teacher.getSchool_cd();

        TestDAO tDao = new TestDAO();
        SubjectDAO sDao = new SubjectDAO();
        ClassNumDAO cDao = new ClassNumDAO();

        // プルダウン用データ取得
        request.setAttribute("class_num_set", cDao.filter(schoolCd));
        request.setAttribute("subject_set", sDao.filter(schoolCd));
        
        // 入学年度リスト（現在から10年前まで）
        List<Integer> entYearSet = new ArrayList<>();
        int year = java.time.LocalDate.now().getYear();
        for (int i = year; i >= year - 10; i--) entYearSet.add(i);
        request.setAttribute("ent_year_set", entYearSet);

        // パラメータ取得
        String f1Str = request.getParameter("f1"); // 入学年度
        String f2 = request.getParameter("f2");    // クラス
        String f3 = request.getParameter("f3");    // 科目
        String f4Str = request.getParameter("f4"); // 回数

        // 検索または登録ボタンが押された場合
        if (f1Str != null) {
            // 入力チェック（いずれかが未選択の場合）
            if (f1Str.equals("0") || f2.equals("0") || f3.equals("0") || f4Str.equals("0")) {
                request.setAttribute("message", "入学年度とクラスと科目と回数を選択してください");
            } else {
                int entYear = Integer.parseInt(f1Str);
                int num = Integer.parseInt(f4Str);

                // 成績データ一覧を取得
                List<Test> tests = tDao.filter(entYear, f2, f3, num, schoolCd);
                
                // 科目情報を別途取得してセット（JSPでの科目名表示用）
                Subject subject = sDao.get(f3, schoolCd);
                
                request.setAttribute("tests", tests);
                request.setAttribute("subject", subject);
                request.setAttribute("f1", entYear);
                request.setAttribute("f2", f2);
                request.setAttribute("f3", f3);
                request.setAttribute("f4", num);
            }
        }
        request.getRequestDispatcher("test_regist.jsp").forward(request, response);
    }
}
