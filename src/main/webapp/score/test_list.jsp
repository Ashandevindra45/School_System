<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績参照 - 得点管理システム</title>
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
        .content-title { background-color: #f0f0f0; padding: 8px 15px; font-size: 14px; font-weight: bold; margin-bottom: 20px; color: #333; border-radius: 2px; }
        
        /* 検索フォーム全体を囲う外枠 */
        .search-container { border: 1px solid #ddd; border-radius: 4px; padding: 5px 0; margin-bottom: 30px; background-color: #ffffff; max-width: 800px; }
        
        /* 各検索フォームの行（科目情報 / 学生情報） */
        .search-row { display: flex; align-items: center; padding: 15px 20px; }
        .search-row:first-child { border-bottom: 1px solid #eee; }
        
        .search-label { width: 100px; font-size: 14px; font-weight: bold; color: #333; }
        .form-flex { display: flex; flex: 1; align-items: flex-end; gap: 15px; }
        
        .form-group { display: flex; flex-direction: column; gap: 4px; }
        .form-group label { font-size: 11px; color: #666; }
        
        .search-row select { padding: 6px; width: 120px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; background-color: #fff; }
        .search-row input[type="text"] { padding: 6px 10px; width: 220px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .search-row input[type="text"]::placeholder { color: #999; }
        
        /* 検索ボタン（グレーの四角ボタン） */
        .search-btn { padding: 6px 16px; background-color: #555; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; margin-left: 10px; }
        .search-btn:hover { background-color: #333; }
        
        /* 下部リンク */
        .back-link { display: inline-block; margin-top: 20px; font-size: 14px; text-decoration: none; color: #0056b3; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <%-- ヘッダーの読み込み --%>
    <jsp:include page="/header.jsp" />
    
    <div class="main-layout">
        <%-- 左側ナビゲーションメニュー --%>
        <div class="sidebar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/auth/Menu.action">メニュー</a></li>
                <li><a href="${pageContext.request.contextPath}/student/StudentList.action">学生管理</a></li>
                <li>
                    <a href="${pageContext.request.contextPath}/score/TestRegist.action">成績管理</a>
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/score/TestRegist.action">成績登録</a></li>
                        <li><a href="${pageContext.request.contextPath}/score/TestList.action" style="font-weight: bold;">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/subject/SubjectList.action">科目管理</a></li>
            </ul>
        </div>

        <%-- 右側メインコンテンツ --%>
        <div class="content">
            <div class="content-title">成績参照</div>

            <%-- エラーまたは案内メッセージ表示 --%>
            <c:if test="${not empty message}">
                <p style="color: red; font-size: 13px; margin-bottom: 15px;">${message}</p>
            </c:if>

            <div class="search-container">
                <%-- 1. 科目情報からの検索フォーム --%>
                <form action="TestListSubjectExecute.action" method="get" class="search-row">
                    <div class="search-label">科目情報</div>
                    <div class="form-flex">
                        
                        <%-- 入学年度 --%>
                        <div class="form-group">
                            <label>入学年度</label>
                            <select name="f1">
                                <option value="0">--------</option>
                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}" ${param.f1 == year ? 'selected' : ''}>${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <%-- クラス --%>
                        <div class="form-group">
                            <label>クラス</label>
                            <select name="f2">
                                <option value="0">--------</option>
                                <c:forEach var="c" items="${class_num_set}">
                                    <option value="${c}" ${param.f2 == c ? 'selected' : ''}>${c}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <%-- 科目 --%>
                        <div class="form-group">
                            <label>科目</label>
                            <select name="f3">
                                <option value="0">--------</option>
                                <c:forEach var="s" items="${subject_set}">
                                    <option value="${s.cd}" ${param.f3 == s.cd ? 'selected' : ''}>${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <button type="submit" class="search-btn">検索</button>
                    </div>
                </form>

                <%-- 2. 学生情報からの検索フォーム --%>
                <form action="TestListStudentExecute.action" method="get" class="search-row">
                    <div class="search-label">学生情報</div>
                    <div class="form-flex">
                        
                        <%-- 学生番号 --%>
                        <div class="form-group">
                            <label>学生番号</label>
                            <input type="text" name="f5" value="${param.f5}" placeholder="学生番号を入力してください">
                        </div>
                        
                        <button type="submit" class="search-btn">検索</button>
                    </div>
                </form>
            </div>

            <%-- 下部の遷移リンク --%>
            <div style="margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/auth/Menu.action" class="back-link">メニューに戻る</a>
            </div>
        </div>
    </div>

</body>
</html>
