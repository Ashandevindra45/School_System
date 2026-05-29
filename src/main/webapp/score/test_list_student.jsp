<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績一覧（学生） - 得点管理システム</title>
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
        
        /* 学生の基本情報表示スタイル */
        .student-info-label { font-size: 14px; margin-bottom: 20px; color: #333; }
        
        /* メッセージ表示（エラー等） */
        .message { color: red; font-size: 13px; font-weight: bold; margin-bottom: 15px; }
        
        /* 成績テーブル（下線のみのモダンスタイルに刷新） */
        .score-table { width: 100%; border-collapse: collapse; font-size: 14px; margin-top: 5px; }
        .score-table th { text-align: left; padding: 10px 8px; border-bottom: 1px solid #999; color: #000; font-weight: bold; white-space: nowrap; }
        .score-table td { padding: 10px 8px; border-bottom: 1px solid #ddd; color: #333; vertical-align: middle; }
        
        /* 戻るリンク */
        .back-link { display: inline-block; margin-top: 30px; font-size: 14px; text-decoration: none; color: #0056b3; }
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
            <div class="content-title">成績一覧（学生）</div>

            <%-- メッセージ（エラー等）表示 --%>
            <c:if test="${not empty message}">
                <p class="message">${message}</p>
            </c:if>

            <c:choose>
                <c:when test="${not empty tests}">
                    <%-- 氏名と番号の表示（科目別画面のラベル仕様に統一） --%>
                    <div class="student-info-label">
                        氏名：<strong>${tests[0].student.name}</strong> 
                        <span style="color: #666; font-size: 13px; margin-left: 10px;">
                            (${tests[0].student.no})
                        </span>
                    </div>

                    <%-- 成績一覧テーブル --%>
                    <table class="score-table">
                        <thead>
                            <tr>
                                <th style="width: 45%;">科目名</th>
                                <th style="width: 15%;">回数</th>
                                <th style="width: 20%;">点数</th>
                                <th style="width: 20%;">クラス</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.subject.name}</td>
                                    <td>${test.no}回</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${test.point >= 0}">${test.point}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${test.classNum}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:if test="${empty message}">
                        <p style="font-size: 14px; color: #666; margin-top: 15px;">学生情報が存在しませんでした。</p>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <%-- 戻るリンク --%>
            <div style="margin-top: 30px;">
                <a href="TestList.action" class="back-link">検索画面に戻る</a>
            </div>
        </div>
    </div>

</body>
</html>
