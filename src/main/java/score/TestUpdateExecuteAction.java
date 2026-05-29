package score;

import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestUpdateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // セッションの取得（false: なければ新規作成しない）
        HttpSession session = request.getSession(false);
        
        // --- 修正箇所: ログインチェックを追加 ---
        if (session == null || session.getAttribute("teacher") == null) {
            // セッション切れの場合はログイン画面へ強制リダイレクト
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 以降の処理（既存のコード）
        String subjectCd = request.getParameter("subject_cd");
        int num = Integer.parseInt(request.getParameter("num"));
        String[] studentNoList = request.getParameterValues("student_no_list");

        if (studentNoList != null) {
            List<Test> tests = new ArrayList<>();
            for (String no : studentNoList) {
                String pointStr = request.getParameter("point_" + no);
                Test t = new Test();
                
                Student s = new Student();
                s.setNo(no);
                t.setStudent(s);
                
                Subject sub = new Subject();
                sub.setCd(subjectCd);
                t.setSubject(sub);
                
                t.setNo(num);
                t.setPoint(Integer.parseInt(pointStr));
                tests.add(t);
            }

            TestDAO dao = new TestDAO();
            // teacher.getSchool_cd() を呼ぶ前にチェックしているので安全
            dao.save(tests, teacher.getSchool_cd());
        }

        request.getRequestDispatcher("test_update_done.jsp").forward(request, response);
    }
}