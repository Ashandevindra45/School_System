<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 科目削除確認</title>
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
        
        /* 注意メッセージ（赤帯風にして視認性を向上） */
        .alert-message { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px 15px; font-size: 14px; font-weight: bold; border-radius: 4px; margin-bottom: 25px; max-width: 700px; }
        
        /* 確認情報エリア */
        .info-container { max-width: 700px; margin-bottom: 25px; }
        .info-group { margin-bottom: 15px; }
        .info-group label { display: block; font-size: 13px; font-weight: bold; color: #555; margin-bottom: 4px; }
        .info-value { font-size: 15px; color: #000; padding-left: 2px; }
        
        /* ボタンエリア */
        .btn-area { margin-top: 30px; margin-bottom: 15px; }
        .delete-btn { 
            padding: 8px 20px; background-color: #dc3545; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; 
        }
        .delete-btn:hover { background-color: #bd2130; }
        
        /* 戻るリンク */
        .back-link { display: inline-block; font-size: 14px; text-decoration: none; color: #0056b3; font-weight: bold; }
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
            <div class="content-title">科目削除</div>

            <%-- 注意警告メッセージ --%>
            <div class="alert-message">
                以下の科目を削除します。よろしいですか？
            </div>

            <%-- 削除対象の科目データ確認表示 --%>
            <div class="info-container">
                <div class="info-group">
                    <label>科目コード</label>
                    <div class="info-value">
                        <c:out value="${not empty subject.cd ? subject.cd : '203'}" />
                    </div>
                </div>
                
                <div class="info-group">
                    <label>科目名</label>
                    <div class="info-value">
                        <c:out value="${not empty subject.name ? subject.name : 'Tamil'}" />
                    </div>
                </div>
            </div>

            <%-- 削除実行フォームとボタン --%>
            <form action="SubjectDeleteExecute.action" method="post">
                <input type="hidden" name="cd" value="${not empty subject.cd ? subject.cd : '203'}">
                <div class="btn-area">
                    <button type="submit" class="delete-btn">削除を実行する</button>
                </div>
            </form>

            <%-- 戻るリンク --%>
            <a href="SubjectList.action" class="back-link">戻る</a>
        </div>
    </div>

</body>
</html>

