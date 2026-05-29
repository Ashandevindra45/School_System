package score;

import java.util.ArrayList;
import java.util.List;

import bean.Teacher;
import bean.Test;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestUpdateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        ClassNumDAO cDao = new ClassNumDAO();
        SubjectDAO sDao = new SubjectDAO();
        TestDAO tDao = new TestDAO();

        // プルダウン用データの準備
        request.setAttribute("class_num_set", cDao.filter(teacher.getSchool_cd()));
        request.setAttribute("subject_set", sDao.filter(teacher.getSchool_cd()));
        
        List<Integer> entYearSet = new ArrayList<>();
        int year = java.time.LocalDate.now().getYear();
        for (int i = year; i >= year - 10; i--) entYearSet.add(i);
        request.setAttribute("ent_year_set", entYearSet);

        // 検索パラメータ取得
        String f1 = request.getParameter("f1"); // 入学年度
        String f2 = request.getParameter("f2"); // クラス
        String f3 = request.getParameter("f3"); // 科目
        String f4 = request.getParameter("f4"); // 回数

        // 全てが選択されている場合のみ検索を実行
        if (f1 != null && !f1.equals("0") && f2 != null && !f2.equals("0") && 
            f3 != null && !f3.equals("0") && f4 != null && !f4.equals("0")) {
            
            List<Test> tests = tDao.filter(
                Integer.parseInt(f1), f2, f3, Integer.parseInt(f4), teacher.getSchool_cd()
            );
            
            request.setAttribute("tests", tests);
            request.setAttribute("f1", f1);
            request.setAttribute("f2", f2);
            request.setAttribute("f3", f3);
            request.setAttribute("f4", f4);
            
            if (tests.isEmpty()) {
                request.setAttribute("message", "該当する成績データが見つかりませんでした。");
            }
        }

        request.getRequestDispatcher("test_update.jsp").forward(request, response);
    }
}

