package student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession(false);

        // セッションチェック: ログインしていない場合はログイン画面へ
        if (session == null || session.getAttribute("teacher") == null) {
            // 絶対パスでリダイレクト (/sample/auth/Login.action)
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("teacher");

        StudentDAO studentDAO = new StudentDAO();
        ClassNumDAO classNumDAO = new ClassNumDAO();

        List<Student> studentList;
        Map<String, String> errors = new HashMap<>();

        // リクエストパラメータの取得
        String entYearStr = request.getParameter("f1");   // 入学年度
        String classNum = request.getParameter("f2");     // クラス
        String isAttendStr = request.getParameter("f3");  // 在学中フラグ

        int entYear = 0;
        boolean isAttend = false;

        // 入学年度の数値変換
        if (entYearStr != null && !entYearStr.isEmpty() && !entYearStr.equals("0")) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                errors.put("f1", "入学年度には数値を指定してください");
            }
        }

        // 在学中チェックボックス (チェックがあれば "on" 等が来る)
        if (isAttendStr != null) {
            isAttend = true;
        }

        // クラス未選択の補正
        if (classNum == null || classNum.isEmpty()) {
            classNum = "0";
        }

        // --- 検索ロジック ---
        // StudentDAOのfilterメソッドが各引数パターンに対応している前提です
        if (entYear != 0 && !classNum.equals("0")) {
            // 全条件指定
            studentList = studentDAO.filter(teacher.getSchool_cd(), entYear, classNum, isAttend);
        } else if (entYear != 0 && classNum.equals("0")) {
            // 入学年度のみ
            studentList = studentDAO.filter(teacher.getSchool_cd(), entYear, isAttend);
        } else if (entYear == 0 && classNum.equals("0")) {
            // 全て未指定（学校コードと在学フラグのみ）
            studentList = studentDAO.filter(teacher.getSchool_cd(), isAttend);
        } else {
            // クラスだけ指定されている場合はエラー（入学年度が必要）
            errors.put("f1", "クラスを指定する場合は入学年度も指定してください");
            studentList = studentDAO.filter(teacher.getSchool_cd(), isAttend);
        }

        // クラス一覧を取得（プルダウン用）
        List<String> classNumList = classNumDAO.filter(teacher.getSchool_cd());

        // JSPへデータを渡す
        request.setAttribute("f1", entYear);      // 選択状態維持用
        request.setAttribute("f2", classNum);     // 選択状態維持用
        request.setAttribute("f3", isAttend);     // 選択状態維持用
        request.setAttribute("studentList", studentList);
        request.setAttribute("class_num_set", classNumList);
        request.setAttribute("errors", errors);

        // JSPへのフォワード（webapp/student/student_list.jsp を指す）
        // ※画像にこのファイルがない場合は作成してください
        request.getRequestDispatcher("/student/student_list.jsp")
               .forward(request, response);
    }
}
