<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - メニュー</title>
    <style>
        body { font-family: sans-serif; margin: 0; padding: 0; background-color: #ffffff; }
        
        /* メインレイアウト（左メニュー＋右コンテンツ） */
        .main-layout { display: flex; max-width: 1200px; margin: 20px auto; padding: 0 15px; min-height: 400px; }
        
        /* 左側サイドメニュー */
        .sidebar { width: 180px; padding-right: 20px; border-right: 1px solid #ddd; }
        .sidebar ul { list-style: none; padding: 0; margin: 0; }
        .sidebar li { margin-bottom: 12px; font-size: 14px; }
        .sidebar a { text-decoration: none; color: #0056b3; }
        .sidebar a:hover { text-decoration: underline; }
        .sidebar .sub-menu { padding-left: 20px; margin-top: 5px; }
        
        /* 右側メインコンテンツ */
        .content { flex: 1; padding-left: 30px; }
        .content-title { background-color: #f0f0f0; padding: 8px 15px; font-size: 14px; font-weight: bold; margin-bottom: 30px; color: #333; border-radius: 2px; }
        
        /* カードコンテナ */
        .card-container { display: flex; gap: 20px; flex-wrap: wrap; }
        
        /* 共通カードスタイル */
        .menu-card { 
            width: 160px; height: 130px; border: 1px solid #ccc; display: flex; 
            flex-direction: column; align-items: center; justify-content: center; 
            text-align: center; padding: 10px; box-sizing: border-box; font-size: 14px;
            border-radius: 4px;
        }
        .menu-card a { text-decoration: none; color: #0056b3; display: block; margin-top: 4px; }
        .menu-card a:hover { text-decoration: underline; }
        .card-title-bold { font-weight: bold; color: #333; margin-bottom: 5px; }
        
        /* 【変更】新しいボックスカラーの設定 */
        .card-student { background-color: #e6f0fa; border-color: #b3d1f2; } /* 薄い青 */
        .card-score { background-color: #e6f5ea; border-color: #b3e2c2; }   /* 薄いエメラルド */
        .card-subject { background-color: #f3eafa; border-color: #d6bbf2; } /* 薄いラベンラー */
    </style>
</head>
<body>

    <%-- ヘッダー（得点管理システム青帯）の読み込み --%>
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
                <li><a href="${pageContext.request.contextPath}/subject/SubjectList.action">科目管理</a></li>
            </ul>
        </div>

        <%-- 右側コンテンツエリア --%>
        <div class="content">
            <div class="content-title">メニュー</div>

            <div class="card-container">
                <%-- 学生管理カード --%>
                <div class="menu-card card-student">
                    <a href="${pageContext.request.contextPath}/student/StudentList.action" style="color: #0056b3; font-weight: bold;">学生管理</a>
                </div>

                <%-- 成績管理カード --%>
                <div class="menu-card card-score">
                    <span class="card-title-bold">成績管理</span>
                    <a href="${pageContext.request.contextPath}/score/TestRegist.action">成績登録</a>
                    <a href="${pageContext.request.contextPath}/score/TestList.action">成績参照</a>
                </div>

                <%-- 科目管理カード --%>
                <div class="menu-card card-subject">
                    <a href="${pageContext.request.contextPath}/subject/SubjectList.action" style="color: #0056b3; font-weight: bold;">科目管理</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
