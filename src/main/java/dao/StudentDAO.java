package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDAO extends DAO {

    private final String baseSql =
            "select * from student where school_cd = ?";

    // 学生番号で取得
    public Student get(String no) throws Exception {

        Student student = null;

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(
                "select * from student where no = ?"
        );

        st.setString(1, no);

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            student = new Student();

            student.setNo(rs.getString("no"));
            student.setName(rs.getString("name"));
            student.setEntYear(rs.getInt("ent_year"));
            student.setClassNum(rs.getString("class_num"));
            student.setIsAttend(rs.getBoolean("is_attend"));
            student.setSchool(rs.getString("school_cd"));
        }

        rs.close();
        st.close();
        con.close();

        return student;
    }

    // （未使用）
    public List<Student> postFilter(ResultSet resultSet, School school) throws Exception {
        return null;
    }

    // 学校コード＋入学年度＋クラス＋在学中
    public List<Student> filter(
            String schoolCd,
            int entYear,
            String classNum,
            boolean isAttend
    ) throws Exception {

        List<Student> list = new ArrayList<>();

        String sql =
                baseSql +
                " and ent_year = ?" +
                " and class_num = ?";

        if (isAttend) {
            sql += " and is_attend = true";
        }

        sql += " order by no asc";

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, schoolCd);
        st.setInt(2, entYear);
        st.setString(3, classNum);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            list.add(createStudent(rs));
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // 学校コード＋入学年度＋在学中
    public List<Student> filter(
            String schoolCd,
            int entYear,
            boolean isAttend
    ) throws Exception {

        List<Student> list = new ArrayList<>();

        String sql =
                baseSql +
                " and ent_year = ?";

        if (isAttend) {
            sql += " and is_attend = true";
        }

        sql += " order by no asc";

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, schoolCd);
        st.setInt(2, entYear);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            list.add(createStudent(rs));
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // 学校コード＋在学中
    public List<Student> filter(
            String schoolCd,
            boolean isAttend
    ) throws Exception {

        List<Student> list = new ArrayList<>();

        String sql = baseSql;

        if (isAttend) {
            sql += " and is_attend = true";
        }

        sql += " order by no asc";

        Connection con = getConnection();

        PreparedStatement st = con.prepareStatement(sql);

        st.setString(1, schoolCd);

        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            list.add(createStudent(rs));
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }

    // 保存（新規登録／更新）
    public boolean save(Student student) throws Exception {

        Connection con = getConnection();
        PreparedStatement st;

        Student old = get(student.getNo());

        if (old == null) {

            st = con.prepareStatement(
                    "insert into student " +
                    "(no, name, ent_year, class_num, is_attend, school_cd) " +
                    "values (?, ?, ?, ?, ?, ?)"
            );

            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt(3, student.getEntYear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.getIsAttend());
            st.setString(6, student.getSchool());

        } else {

            st = con.prepareStatement(
                    "update student " +
                    "set name = ?, ent_year = ?, class_num = ?, is_attend = ? " +
                    "where no = ?"
            );

            st.setString(1, student.getName());
            st.setInt(2, student.getEntYear());
            st.setString(3, student.getClassNum());
            st.setBoolean(4, student.getIsAttend());
            st.setString(5, student.getNo());
        }

        st.executeUpdate();

        st.close();
        con.close();

        return true;
    }

    // ResultSet → Student変換
    private Student createStudent(ResultSet rs) throws Exception {

        Student student = new Student();

        student.setNo(rs.getString("no"));
        student.setName(rs.getString("name"));
        student.setEntYear(rs.getInt("ent_year"));
        student.setClassNum(rs.getString("class_num"));
        student.setIsAttend(rs.getBoolean("is_attend"));
        student.setSchool(rs.getString("school_cd"));

        return student;
    }
}