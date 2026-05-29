<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>科目一覧 - 得点管理システム</title>
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
        
        /* 新規登録リンクの位置（右寄せ） */
        .create-link { position: absolute; right: 0; top: 45px; font-size: 13px; }
        .create-link a { text-decoration: none; color: #0056b3; }
        .create-link a:hover { text-decoration: underline; }
        
        /* 科目一覧テーブル（幅いっぱいに広げ、下線のみのスタイルへ） */
        .subject-table { width: 100%; border-collapse: collapse; margin-top: 40px; font-size: 14px; }
        .subject-table th { text-align: left; padding: 10px 8px; border-bottom: 1px solid #999; color: #000; font-weight: bold; white-space: nowrap; }
        .subject-table td { padding: 10px 8px; border-bottom: 1px solid #ddd; color: #333; vertical-align: middle; }
        
        /* 操作リンク（変更・削除） */
        .action-links { text-align: right; }
        .action-links a { text-decoration: none; color: #0056b3; margin-left: 15px; }
        .action-links a:hover { text-decoration: underline; }
        
        /* メッセージ・下部リンク */
        .info-message { font-size: 14px; color: #666; margin-top: 20px; }
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
                        <li><a href="${pageContext.request.contextPath}/score/TestList.action">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/subject/SubjectList.action" style="font-weight: bold;">科目管理</a></li>
            </ul>
        </div>

        <%-- 右側メインコンテンツ --%>
        <div class="content">
            <div class="content-title">科目一覧</div>

            <%-- 新規登録画面へのリンク（学生管理とデザインを統一） --%>
            <div class="create-link">
                <a href="SubjectCreate.action">新規登録</a>
            </div>

            <c:choose>
                <%-- 科目データが存在する場合 --%>
                <c:when test="${not empty subjectList}">
                    <table class="subject-table">
                        <thead>
                            <tr>
                                <th style="width: 30%;">科目コード</th>
                                <th style="width: 50%;">科目名</th>
                                <th style="width: 20%;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="subject" items="${subjectList}">
                                <tr>
                                    <td>${subject.cd}</td>
                                    <td>${subject.name}</td>
                                    <td class="action-links">
                                        <%-- 変更・削除リンク --%>
                                        <a href="SubjectUpdate.action?cd=${subject.cd}">変更</a>
                                        <a href="SubjectDelete.action?cd=${subject.cd}" onclick="return confirm('本当に削除しますか？');">削除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                
                <%-- 科目データが空の場合（テスト用のダミー行入り。本番不要ならc:otherwise内を空にしてください） --%>
                <c:otherwise>
                    <table class="subject-table">
                        <thead>
                            <tr>
                                <th style="width: 30%;">科目コード</th>
                                <th style="width: 50%;">科目名</th>
                                <th style="width: 20%;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>201</td>
                                <td>Maths</td>
                                <td class="action-links">
                                    <a href="SubjectUpdate.action?cd=201">変更</a>
                                    <a href="SubjectDelete.action?cd=201" onclick="return confirm('本当に削除しますか？');">削除</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>

            <div style="margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/auth/Menu.action" class="back-link">メニューに戻る</a>
            </div>
        </div>
    </div>

</body>
</html>
