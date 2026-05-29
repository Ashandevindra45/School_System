package subject; // または適切なパッケージ名

import java.util.List;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public void execute(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws Exception {

        // 1. セッションからユーザーデータ（Teacher）を取得
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 2. DAOを使って、ユーザーが所属している学校の科目一覧データを取得
        SubjectDAO subjectDAO = new SubjectDAO();
        // 学校コードに合致する科目の一覧を取得
        List<Subject> subjectList = subjectDAO.filter(teacher.getSchool_cd());

        // 3. リクエスト属性にセットしてJSPへ転送
        request.setAttribute("subjectList", subjectList);
        
        // subject_list.jspへフォワード
        request.getRequestDispatcher("/subject/subject_list.jsp").forward(request, response);
    }
}
