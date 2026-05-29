package student;

import java.util.HashMap;
import java.util.Map;

import bean.Student;
import bean.Teacher;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(); // セッションの利用
		Teacher teacher = (Teacher)session.getAttribute("teacher");//teacher取り出し
		Student student = new Student();//新規登録情報保存用
		StudentDAO studentdao = new StudentDAO();//studentテーブルアクセス
		Map<String, String> errors = new HashMap<>(); // エラーメッセージ

		// リクエストパラメーターの取得
		int ent_year = Integer.parseInt(request.getParameter("ent_year"));//入学年度の取得
		String student_no = request.getParameter("no");//学生番号の取得
		String student_name = request.getParameter("name");//氏名の取得
		String class_num = request.getParameter("class_num");//クラス番号の取得

		if (ent_year == 0) { // 入学年度が未選択だった場合
			errors.put("1", "入学年度を選択してください");
			// リクエストにエラーメッセージをセット
			request.setAttribute("errors", errors);
		} else {
			if (studentdao.get(student_no) != null) { // 学生番号の重複チェック
				errors.put("2", "学生番号が重複しています");
				// リクエストにエラーメッセージをセット
				request.setAttribute("errors", errors);
			} else {
				// studentに学生情報をセット
				student.setNo(student_no);
				student.setName(student_name);
				student.setEntYear(ent_year);
				student.setClassNum(class_num);
				student.setIsAttend(true);
				student.setSchool(teacher.getSchool_cd());
				// saveメソッドで情報を登録
				studentdao.save(student);
			}
		}
		request.setAttribute("ent_year", ent_year);
		// リクエストに学生番号をセット
		request.setAttribute("no", student_no);
		// リクエストに氏名をセット
		request.setAttribute("name", student_name);
		// リクエストにクラス番号をセット
		request.setAttribute("class_num", class_num);

		// JSPへフォワード
		if (errors.isEmpty()) { // エラーメッセージがない場合
			// 登録完了画面にフォワード
			request.getRequestDispatcher("student_create_done.jsp").forward(request, response);
		} else { // エラーメッセージがある場合
			// 登録画面にフォワード
			request.getRequestDispatcher("StudentCreate.action").forward(request, response);
		}
	}
}