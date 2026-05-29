<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>学生管理</title>
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
        .content { flex: 1; padding-left: 30px; position: relative; }
        .content-title { background-color: #f0f0f0; padding: 8px 15px; font-size: 14px; font-weight: bold; margin-bottom: 15px; color: #333; border-radius: 2px; }
        
        /* 新規登録リンクの位置 */
        .create-link { position: absolute; right: 0; top: 45px; font-size: 13px; }
        .create-link a { text-decoration: none; color: #0056b3; }
        .create-link a:hover { text-decoration: underline; }
        
        /* 検索フォームエリア */
        .search-box { background-color: #ffffff; border: 1px solid #ddd; padding: 15px; border-radius: 4px; display: flex; align-items: flex-end; gap: 15px; margin-top: 40px; margin-bottom: 25px; }
        .form-group { display: flex; flex-direction: column; gap: 5px; }
        .form-group label { font-size: 12px; color: #333; }
        .search-box select { padding: 6px; width: 140px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; background-color: #fff; }
        .checkbox-group { display: flex; align-items: center; gap: 5px; font-size: 13px; padding-bottom: 6px; }
        
        /* 絞込みボタン */
        .search-btn { padding: 6px 15px; background-color: #555; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; }
        .search-btn:hover { background-color: #333; }
        
        /* 検索結果・テーブル */
        .result-count { font-size: 14px; font-weight: bold; margin-bottom: 10px; color: #333; }
        .student-table { width: 100%; border-collapse: collapse; margin-top: 5px; font-size: 14px; }
        .student-table th { text-align: left; padding: 10px 8px; border-bottom: 1px solid #999; color: #000; font-weight: bold; }
        .student-table td { padding: 10px 8px; border-bottom: 1px solid #ddd; color: #333; vertical-align: middle; }
        .student-table a { text-decoration: none; color: #0056b3; }
        .student-table a:hover { text-decoration: underline; }
        
        /* メッセージ表示 */
        .info-message { font-size: 14px; color: #666; margin-top: 15px; }
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
            <div class="content-title">学生管理</div>
            
            <%-- 新規登録リンク --%>
            <div class="create-link">
                <a href="StudentCreate.action">新規登録</a>
            </div>

            <%-- エラーメッセージ表示 --%>
            <c:if test="${not empty errors.f1}">
                <div style="color: red; font-size: 13px; margin-bottom: 10px;">
                    ${errors.f1}
                </div>
            </c:if>

            <%-- 検索フォーム（絞込みエリア） --%>
            <form method="get" action="StudentList.action" class="search-box">
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="f1">
                        <option value="0">--------</option>
                        <option value="2020" ${param.f1 == '2020' ? 'selected' : ''}>2020</option>
                        <option value="2021" ${param.f1 == '2021' ? 'selected' : ''}>2021</option>
                        <option value="2022" ${param.f1 == '2022' ? 'selected' : ''}>2022</option>
                        <option value="2023" ${param.f1 == '2023' ? 'selected' : ''}>2023</option>
                        <option value="2024" ${param.f1 == '2024' ? 'selected' : ''}>2024</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>クラス</label>
                    <select name="f2">
                        <option value="0">--------</option>
                        <option value="101" ${param.f2 == '101' ? 'selected' : ''}>101</option>
                        <option value="102" ${param.f2 == '102' ? 'selected' : ''}>102</option>
                        <option value="201" ${param.f2 == '201' ? 'selected' : ''}>201</option>
                        <option value="202" ${param.f2 == '202' ? 'selected' : ''}>202</option>
                    </select>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" id="f3" name="f3" <c:if test="${not empty param.f3}">checked</c:if> />
                    <label for="f3">在学中</label>
                </div>

                <button type="submit" class="search-btn">絞込み</button>
            </form>

            <%-- 学生一覧テーブルエリア --%>
            <c:choose>
                <c:when test="${not empty studentList}">
                    <div class="result-count">検索結果：${studentList.size()}件</div>

                    <table class="student-table">
                        <thead>
                            <tr>
                                <th style="width: 15%;">入学年度</th>
                                <th style="width: 15%;">学生番号</th>
                                <th style="width: 35%;">氏名</th>
                                <th style="width: 15%;">クラス</th>
                                <th style="width: 10%;">在学中</th>
                                <th style="width: 10%;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${studentList}">
                                <tr>
                                    <td>${s.entYear}</td>
                                    <td>${s.no}</td>
                                    <td>${s.name}</td>
                                    <td>${s.classNum}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.isAttend}">◯</c:when>
                                            <c:otherwise>×</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align: right;">
                                        <a href="StudentUpdate.action?no=${s.no}">変更</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="info-message">学生情報が存在しませんでした。</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>
