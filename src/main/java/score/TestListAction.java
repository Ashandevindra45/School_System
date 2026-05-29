package score;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.Teacher;
import dao.ClassNumDAO;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        // 1. セッションチェック
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            // ログインしていない場合はログイン画面へ
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }

        Teacher teacher = (Teacher) session.getAttribute("teacher");
        String schoolCd = teacher.getSchool_cd();

        // 2. 各DAOの初期化
        ClassNumDAO cDao = new ClassNumDAO();
        SubjectDAO sDao = new SubjectDAO();

        // 3. 入学年度リストの生成（現在の年から10年前まで）
        List<Integer> entYearSet = new ArrayList<>();
        int currentYear = LocalDate.now().getYear();
        for (int i = currentYear; i >= currentYear - 10; i--) {
            entYearSet.add(i);
        }

        // 4. JSPのプルダウンで使用するデータをリクエスト属性にセット
        request.setAttribute("ent_year_set", entYearSet);
        request.setAttribute("class_num_set", cDao.filter(schoolCd));
        request.setAttribute("subject_set", sDao.filter(schoolCd));

        // 5. 検索画面（test_list.jsp）へフォワード
        // パッケージがscoreなので、同じディレクトリ内のjspを指す
        request.getRequestDispatcher("test_list.jsp").forward(request, response);
    }
}
