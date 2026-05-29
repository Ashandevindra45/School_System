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

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 1. セッションチェック
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 2. パラメータ取得
        String subjectCd = request.getParameter("subject_cd");
        int num = Integer.parseInt(request.getParameter("num"));
        String[] studentNoList = request.getParameterValues("student_no_list");

        List<Test> tests = new ArrayList<>();
        if (studentNoList != null) {
            for (String no : studentNoList) {
                String pointStr = request.getParameter("point_" + no);
                int point = Integer.parseInt(pointStr);

                // 3. バリデーション（0〜100チェック）
                if (point < 0 || point > 100) {
                    request.setAttribute("message", "0〜100の間で入力してください");
                    // 検索状態を維持して入力画面に戻す
                    request.getRequestDispatcher("TestRegist.action").forward(request, response);
                    return;
                }

                // 4. Testオブジェクトの組み立て
                Test t = new Test();
                Student s = new Student();
                s.setNo(no);
                t.setStudent(s);
                
                Subject sub = new Subject();
                sub.setCd(subjectCd);
                t.setSubject(sub);
                
                t.setNo(num);
                t.setPoint(point);
                tests.add(t);
            }
        }

        // 5. DB保存（DAOのsaveメソッド内でクラス番号が補完される）
        TestDAO dao = new TestDAO();
        dao.save(tests, teacher.getSchool_cd());

        // 6. 完了画面へ
        request.getRequestDispatcher("test_regist_done.jsp").forward(request, response);
    }
}
