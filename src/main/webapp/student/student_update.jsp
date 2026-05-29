<%-- 学生情報変更JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 学生情報変更</title>
    <style>
        body { font-family: sans-serif; margin: 0; padding: 0; background-color: #ffffff; }
        
        /* メインレイアウト（左メニュー＋右コンテンツ） */
        .main-layout { display: flex; max-width: 1200px; margin: 20px auto; padding: 0 15px; min-height: 500px; }
        
        /* 左側サイドメニュー */
        .sidebar { width: 180px; padding-right: 20px; border-right: 1px solid #ddd; }
        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        .sidebar li { margin-bottom: 12px; font-size: 14px; }
        .sidebar a { text-decoration: none; color: #0056b3; }
        .sidebar a:hover { text-decoration: underline; }
        .sidebar .sub-menu { padding-left: 20px; margin-top: 5px; }
        
        /* 右側メインコンテンツ */
        .content { flex: 1; padding-left: 30px; }
        .content-title { background-color: #f0f0f0; padding: 8px 15px; font-size: 14px; font-weight: bold; margin-bottom: 25px; color: #333; border-radius: 2px; }
        
        /* フォームレイアウト */
        .form-container { max-width: 700px; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-size: 13px; font-weight: bold; color: #000; margin-bottom: 6px; }
        
        /* 編集不可データのテキスト表示スタイル */
        .static-text { font-size: 14px; color: #333; padding: 2px 0 6px 0; }
        
        /* 入力コントロール（横いっぱいに広げる） */
        .form-control { 
            width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; 
            font-size: 14px; box-sizing: border-box; background-color: #fff;
        }
        
        /* 在学中チェックボックスの並び */
        .checkbox-group { display: flex; align-items: center; gap: 8px; margin-bottom: 25px; }
        .checkbox-group label { margin-bottom: 0; }
        
        /* 変更ボタン（鮮やかなブルー） */
        .btn-area { margin-top: 25px; margin-bottom: 15px; }
        .submit-btn { 
            padding: 8px 24px; background-color: #007bff; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; 
        }
        .submit-btn:hover { background-color: #0056b3; }
        
        /* 戻るリンク */
        .back-link { display: inline-block; font-size: 14px; text-decoration: none; color: #0056b3; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <%-- ヘッダーの読み込み --%>
    <jsp:include page="/header.jsp" />

    <div class="main-layout">
        <%-- 左側サイドメニュー --%>
        <div class="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/auth/Menu.action">メニュー</a></li>
                <li><a href="${pageContext.request.contextPath}/student/StudentList.action" style="font-weight: bold;">学生管理</a></li>
                <li>
                    <a href="${pageContext.request.contextPath}/score/TestRegist.action">成績管理</a>
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/score/TestRegist.action">成績登録</a></li>
                        <li><a href="${pageContext.request.contextPath}/score/TestList.action">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/subject/SubjectList.action">科目管理</a></li>
            </ul>
        </div>

        <%-- 右側メインコンテンツ --%>
        <div class="content">
            <div class="content-title">学生情報変更</div>

            <form action="StudentUpdateExecute.action" method="get" class="form-container">
                
                <%-- 入学年度（画像に合わせてテキスト表示） --%>
                <div class="form-group">
                    <label>入学年度</label>
                    <div class="static-text">${ent_year}</div>
                    <input type="hidden" name="ent_year" value="${ent_year}" />
                </div>

                <%-- 学生番号（画像に合わせてテキスト表示） --%>
                <div class="form-group">
                    <label>学生番号</label>
                    <div class="static-text">${no}</div>
                    <input type="hidden" name="no" value="${no}" />
                </div>

                <%-- 氏名 --%>
                <div class="form-group">
                    <label>氏名</label>
                    <input type="text" name="name" value="${name}" class="form-control" required maxlength="30" />
                </div>

                <%-- クラス --%>
                <div class="form-group">
                    <label>クラス</label>
                    <select name="class_num" class="form-control">
                        <c:forEach var="num" items="${class_num_set}">
                            <option value="${num}" <c:if test="${num == class_num}">selected</c:if>>${num}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- 在学中チェックボックス --%>
                <div class="checkbox-group">
                    <label>在学中</label>
                    <input type="checkbox" name="is_attend" <c:if test="${is_attend}">checked</c:if> />
                </div>

                <%-- ボタンエリア --%>
                <div class="btn-area">
                    <button type="submit" name="login" class="submit-btn">変更</button>
                </div>
            </form>

            <%-- 戻るリンク --%>
            <a href="StudentList.action" class="back-link">戻る</a>
        </div>
    </div>

</body>
</html>
