package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Subject;

public class SubjectDAO extends DAO {

    /**
     * 科目情報を1件取得する
     * @param cd 科目コード
     * @param school_cd 学校コード
     * @return Subjectオブジェクト（存在しない場合はnull）
     */
    public Subject get(String cd, String school_cd) throws Exception {
        Subject subject = null;
        Connection con = getConnection();
        
        // 主キー（科目コードと学校コード）で検索
        PreparedStatement st = con.prepareStatement(
            "select * from subject where cd = ? and school_cd = ?"
        );
        st.setString(1, cd);
        st.setString(2, school_cd);
        ResultSet resultSet = st.executeQuery();

        if (resultSet.next()) {
            subject = new Subject();
            subject.setCd(resultSet.getString("cd"));
            subject.setName(resultSet.getString("name"));
        }
        
        st.close();
        con.close();
        return subject;
    }

    /**
     * 指定した学校の科目一覧を取得する
     * @param school_cd 学校コード
     * @return 科目リスト
     */
    public List<Subject> filter(String school_cd) throws Exception {
        List<Subject> list = new ArrayList<>();
        Connection con = getConnection();
        
        // 学校コードで絞り込み、科目コード順に並び替え
        PreparedStatement st = con.prepareStatement(
            "select * from subject where school_cd = ? order by cd asc"
        );
        st.setString(1, school_cd);
        
        ResultSet resultSet = st.executeQuery();
        while (resultSet.next()) {
            Subject subject = new Subject();
            subject.setCd(resultSet.getString("cd"));
            subject.setName(resultSet.getString("name"));
            list.add(subject);
        }
        
        st.close();
        con.close();
        return list;
    }

    /**
     * 科目情報を保存する（新規登録または更新）
     * @param subject 保存する科目データ
     * @param school_cd 学校コード
     * @return 成功した場合はtrue
     */
    public boolean save(Subject subject, String school_cd) throws Exception {
        Connection con = getConnection();
        PreparedStatement st = null;
        
        // 既存データの有無を確認
        Subject old = get(subject.getCd(), school_cd);
        
        if (old == null) {
            // データがなければ新規登録(INSERT)
            st = con.prepareStatement(
                "insert into subject(cd, name, school_cd) values(?, ?, ?)"
            );
            st.setString(1, subject.getCd());
            st.setString(2, subject.getName());
            st.setString(3, school_cd);
        } else {
            // データがあれば科目名を更新(UPDATE)
            st = con.prepareStatement(
                "update subject set name = ? where cd = ? and school_cd = ?"
            );
            st.setString(1, subject.getName());
            st.setString(2, subject.getCd());
            st.setString(3, school_cd);
        }

        int count = st.executeUpdate();
        
        st.close();
        con.close();
        return count > 0;
    }

    /**
     * 科目情報を削除する
     * @param subject 削除する科目データ
     * @param school_cd 学校コード
     * @return 成功した場合はtrue
     */
    public boolean delete(Subject subject, String school_cd) throws Exception {
        Connection con = getConnection();
        
        // 科目コードと学校コードが一致するレコードを削除
        PreparedStatement st = con.prepareStatement(
            "delete from subject where cd = ? and school_cd = ?"
        );
        st.setString(1, subject.getCd());
        st.setString(2, school_cd);

        int count = st.executeUpdate();
        
        st.close();
        con.close();
        return count > 0;
    }
}
