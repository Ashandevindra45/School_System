package score;

import java.util.List;

import bean.Teacher;
import bean.Test;
import dao.TestDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListStudentExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("teacher") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/Login.action");
            return;
        }
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        // 学生番号(f5)を取得
        String studentNo = request.getParameter("f5");

        TestDAO dao = new TestDAO();
        List<Test> tests = null;

        // studentNo が null または空文字でないことを確認
        if (studentNo != null && !studentNo.isEmpty()) {
            // DAOの呼び出し
            tests = dao.filterByStudent(studentNo, teacher.getSchool_cd());
        }

        if (tests == null || tests.isEmpty()) {
            request.setAttribute("message", "学生情報が存在しませんでした");
        } else {
            request.setAttribute("tests", tests);
        }

        request.getRequestDispatcher("test_list_student.jsp").forward(request, response);
    }
}
