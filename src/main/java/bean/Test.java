package bean;

import java.io.Serializable;

public class Test implements Serializable {
    private Student student;  // 学生情報
    private Subject subject;  // 科目情報
    private String schoolCd;  // 学校コード
    private int no;           // 回数 (1回目, 2回目など)
    private int point;        // 得点
    private String classNum;  // クラス番号

    // Getter / Setter
    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }

    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }

    public String getSchoolCd() { return schoolCd; }
    public void setSchoolCd(String schoolCd) { this.schoolCd = schoolCd; }

    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }

    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }

    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }
}
