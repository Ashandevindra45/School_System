package student;

import java.util.List;

import bean.Teacher;
import dao.ClassNumDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateAction extends Action {

	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(); // セッションを利用するため
		Teacher teacher = (Teacher)session.getAttribute("teacher");//セッションのteacherを取り出すため
		ClassNumDAO classnumDAO = new ClassNumDAO();//classnumテーブルアクセスのため

		List<String> classnum = classnumDAO.filter(teacher.getSchool_cd());
		//dao実行の結果、↑クラス番号取得

		// リクエストにデータをセット
		request.setAttribute("classnum", classnum);

		request.getRequestDispatcher("student_create.jsp").forward(request, response);
	}

}
