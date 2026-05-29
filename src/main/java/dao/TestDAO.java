package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDAO extends DAO {

    /**
     * 【成績登録・変更・科目別参照用】
     */
    public List<Test> filter(int entYear, String classNum, String subjectCd, int num, String schoolCd) throws Exception {
        List<Test> list = new ArrayList<>();
        Connection con = getConnection();
        String sql = "SELECT S.NO AS STUDENT_NO, S.NAME AS STUDENT_NAME, S.ENT_YEAR, S.CLASS_NUM, T.POINT " +
                     "FROM STUDENT S " +
                     "LEFT JOIN TEST T ON S.NO = T.STUDENT_NO AND T.SUBJECT_CD = ? AND T.NO = ? AND T.SCHOOL_CD = ? " +
                     "WHERE S.ENT_YEAR = ? AND S.CLASS_NUM = ? AND S.SCHOOL_CD = ? " +
                     "ORDER BY S.NO ASC";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, subjectCd); st.setInt(2, num); st.setString(3, schoolCd);
        st.setInt(4, entYear); st.setString(5, classNum); st.setString(6, schoolCd);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Test test = new Test();
            Student student = new Student();
            student.setNo(rs.getString("STUDENT_NO"));
            student.setName(rs.getString("STUDENT_NAME"));
            student.setClassNum(rs.getString("CLASS_NUM"));
            test.setStudent(student);
            test.setPoint(rs.wasNull() ? -1 : rs.getInt("POINT"));
            list.add(test);
        }
        st.close(); con.close();
        return list;
    }

    /**
     * 【成績参照（科目別）用：全回数取得】
     */
    public List<Test> filter(int entYear, String classNum, String subjectCd, String schoolCd) throws Exception {
        List<Test> list = new ArrayList<>();
        Connection con = getConnection();
        String sql = "SELECT S.NO AS STUDENT_NO, S.NAME AS STUDENT_NAME, S.ENT_YEAR, S.CLASS_NUM, T.NO AS TEST_NO, T.POINT " +
                     "FROM STUDENT S " +
                     "LEFT JOIN TEST T ON S.NO = T.STUDENT_NO AND T.SUBJECT_CD = ? AND T.SCHOOL_CD = ? " +
                     "WHERE S.ENT_YEAR = ? AND S.CLASS_NUM = ? AND S.SCHOOL_CD = ? " +
                     "ORDER BY S.NO ASC, T.NO ASC";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, subjectCd); st.setString(2, schoolCd);
        st.setInt(3, entYear); st.setString(4, classNum); st.setString(5, schoolCd);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Test test = new Test();
            Student student = new Student();
            student.setNo(rs.getString("STUDENT_NO"));
            student.setName(rs.getString("STUDENT_NAME"));
            student.setClassNum(rs.getString("CLASS_NUM"));
            test.setStudent(student);
            test.setNo(rs.getInt("TEST_NO"));
            test.setPoint(rs.wasNull() ? -1 : rs.getInt("POINT"));
            list.add(test);
        }
        st.close(); con.close();
        return list;
    }

    /**
     * 【成績参照（学生別）用】
     * STUDENTテーブルからCLASS_NUM(101等)を直接取得するように結合
     */
    public List<Test> filterByStudent(String studentNo, String schoolCd) throws Exception {
        List<Test> list = new ArrayList<>();
        Connection con = getConnection();
        String sql = "SELECT S.NAME AS STUDENT_NAME, S.CLASS_NUM, SUB.NAME AS SUBJECT_NAME, " +
                     "T.SUBJECT_CD, T.NO AS TEST_NO, T.POINT " +
                     "FROM TEST T " +
                     "JOIN STUDENT S ON T.STUDENT_NO = S.NO AND T.SCHOOL_CD = S.SCHOOL_CD " +
                     "JOIN SUBJECT SUB ON T.SUBJECT_CD = SUB.CD AND T.SCHOOL_CD = SUB.SCHOOL_CD " +
                     "WHERE T.STUDENT_NO = ? AND T.SCHOOL_CD = ? " +
                     "ORDER BY T.SUBJECT_CD ASC, T.NO ASC";
        PreparedStatement st = con.prepareStatement(sql);
        st.setString(1, studentNo); st.setString(2, schoolCd);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Test test = new Test();
            test.setNo(rs.getInt("TEST_NO"));
            test.setPoint(rs.getInt("POINT"));
            test.setClassNum(rs.getString("CLASS_NUM")); // クラス番号をセット

            Student student = new Student();
            student.setNo(studentNo);
            student.setName(rs.getString("STUDENT_NAME"));
            student.setClassNum(rs.getString("CLASS_NUM"));
            test.setStudent(student);

            Subject subject = new Subject();
            subject.setName(rs.getString("SUBJECT_NAME"));
            subject.setCd(rs.getString("SUBJECT_CD"));
            test.setSubject(subject);
            list.add(test);
        }
        st.close(); con.close();
        return list;
    }

    /**
     * 【一括保存】
     */
    public void save(List<Test> tests, String schoolCd) throws Exception {
        Connection con = getConnection();
        try {
            for (Test t : tests) {
                PreparedStatement checkSt = con.prepareStatement(
                    "SELECT COUNT(*) FROM TEST WHERE STUDENT_NO=? AND SUBJECT_CD=? AND SCHOOL_CD=? AND NO=?");
                checkSt.setString(1, t.getStudent().getNo());
                checkSt.setString(2, t.getSubject().getCd());
                checkSt.setString(3, schoolCd);
                checkSt.setInt(4, t.getNo());
                ResultSet rs = checkSt.executeQuery(); rs.next();
                int count = rs.getInt(1); checkSt.close();

                PreparedStatement saveSt;
                if (count > 0) {
                    saveSt = con.prepareStatement(
                        "UPDATE TEST SET POINT=? WHERE STUDENT_NO=? AND SUBJECT_CD=? AND SCHOOL_CD=? AND NO=?");
                    saveSt.setInt(1, t.getPoint());
                    saveSt.setString(2, t.getStudent().getNo());
                    saveSt.setString(3, t.getSubject().getCd());
                    saveSt.setString(4, schoolCd);
                    saveSt.setInt(5, t.getNo());
                } else {
                    saveSt = con.prepareStatement(
                        "INSERT INTO TEST (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) " +
                        "VALUES (?, ?, ?, ?, ?, (SELECT CLASS_NUM FROM STUDENT WHERE NO=? AND SCHOOL_CD=?))");
                    saveSt.setString(1, t.getStudent().getNo());
                    saveSt.setString(2, t.getSubject().getCd());
                    saveSt.setString(3, schoolCd);
                    saveSt.setInt(4, t.getNo());
                    saveSt.setInt(5, t.getPoint());
                    saveSt.setString(6, t.getStudent().getNo());
                    saveSt.setString(7, schoolCd);
                }
                saveSt.executeUpdate(); saveSt.close();
            }
        } finally { con.close(); }
    }
}
