<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 科目変更</title>
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
        
        /* 入力コントロール（横いっぱいに広げるスタイル） */
        .form-control { 
            width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; 
            font-size: 14px; box-sizing: border-box; background-color: #fff;
        }
        
        /* 変更ボタン（学生変更画面と合わせた鮮やかなブルー） */
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
            <div class="content-title">科目変更</div>

            <form action="SubjectUpdateExecute.action" method="post" class="form-container">
                
                <%-- 科目コード（変更不可のためテキスト表示＋hidden） --%>
                <div class="form-group">
                    <label>科目コード</label>
                    <div class="static-text">
                        <c:out value="${not empty subject.cd ? subject.cd : '201'}" />
                    </div>
                    <input type="hidden" name="cd" value="${not empty subject.cd ? subject.cd : '201'}">
                </div>

                <%-- 科目名入力 --%>
                <div class="form-group">
                    <label>科目名</label>
                    <input type="text" name="name" value="${not empty subject.name ? subject.name : 'Maths'}" class="form-control" required>
                </div>

                <%-- 変更ボタン --%>
                <div class="btn-area">
                    <button type="submit" class="submit-btn">変更</button>
                </div>
            </form>

            <%-- 戻るリンク --%>
            <a href="SubjectList.action" class="back-link">戻る</a>
        </div>
    </div>

</body>
</html>
