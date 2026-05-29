package student;

import java.util.List;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDAO;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateAction extends Action {

	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(); // セッション
		Teacher teacher = (Teacher)session.getAttribute("teacher");
		Student student = new Student();
		StudentDAO studentdao = new StudentDAO();
		ClassNumDAO classnumdao = new ClassNumDAO();

		String no = request.getParameter("no");//学生番号の取得

		// 学生の詳細データを取得
		student = studentdao.get(no);
		// ログインユーザーの学校コードをもとにクラス番号の一覧を取得
		List<String> class_num_set = classnumdao.filter(teacher.getSchool_cd());

		int ent_year = student.getEntYear();//入学年度の取得
		String name = student.getName();//氏名の取得
		String class_num = student.getClassNum();//クラス番号の取得
		boolean isAttend = student.getIsAttend();//在籍有無の取得

		// リクエストに入学年度をセット
		request.setAttribute("ent_year", ent_year);
		// リクエストに学生番号をセット
		request.setAttribute("no", no);
		// リクエストに氏名をセット
		request.setAttribute("name", name);
		// リクエストにクラス番号をセット
		request.setAttribute("class_num", class_num);
		// リクエストにクラス番号の一覧をセット
		request.setAttribute("class_num_set", class_num_set);
		// リクエストに在学フラグをセット
		request.setAttribute("is_attend", isAttend);

		// JSPへフォワード 7
		request.getRequestDispatcher("student_update.jsp").forward(request, response);
	}

}