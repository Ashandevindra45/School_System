<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 科目登録</title>
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
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; color: #333; margin-bottom: 6px; }
        
        /* 入力コントロール（横いっぱいに広げるスタイル） */
        .form-control { 
            width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; 
            font-size: 14px; box-sizing: border-box; background-color: #fff;
        }
        
        /* エラーメッセージ */
        .error-message { color: red; font-size: 12px; margin-top: 4px; }
        
        /* ボタンエリア */
        .btn-area { margin-top: 30px; margin-bottom: 15px; }
        .submit-btn { 
            padding: 8px 20px; background-color: #5a5a5a; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; 
        }
        .submit-btn:hover { background-color: #444; }
        
        /* 戻るリンク */
        .back-link { display: inline-block; margin-top: 10px; font-size: 14px; text-decoration: none; color: #0056b3; font-weight: bold; }
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
            <div class="content-title">科目登録</div>

            <form action="SubjectCreateExecute.action" method="post" class="form-container">
                
                <%-- 科目コード入力 --%>
                <div class="form-group">
                    <label>科目コード(3文字)</label>
                    <input type="text" name="cd" value="${cd}" class="form-control" required maxlength="3">
                    <c:if test="${not empty errors.cd}">
                        <div class="error-message">${errors.cd}</div>
                    </c:if>
                </div>

                <%-- 科目名入力 --%>
                <div class="form-group">
                    <label>科目名</label>
                    <input type="text" name="name" value="${name}" class="form-control" required>
                </div>

                <%-- 登録ボタン --%>
                <div class="btn-area">
                    <button type="submit" class="submit-btn">登録</button>
                </div>
            </form>

            <%-- 戻るリンク --%>
            <a href="SubjectList.action" class="back-link">戻る</a>
        </div>
    </div>

</body>
</html>
