package student;

import bean.Student;
import dao.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Student student = new Student();
		StudentDAO studentdao = new StudentDAO();
		boolean isAttend = false;

		// リクエストパラメータの取得
		int ent_year = Integer.parseInt(request.getParameter("ent_year"));
		String no = request.getParameter("no");
		String name = request.getParameter("name");
		String class_num = request.getParameter("class_num");
		String isAttendStr = request.getParameter("is_attend");

		if (isAttendStr != null) {
			isAttend = true;
		}
		// studentに学生情報をセット
		student.setNo(no);
		student.setName(name);
		student.setEntYear(ent_year);
		student.setClassNum(class_num);
		student.setIsAttend(isAttend);
		// 変更内容を保存
		studentdao.save(student);

		// JSPへフォワード 7
		request.getRequestDispatcher("student_update_done.jsp").forward(request, response);
	}

}
