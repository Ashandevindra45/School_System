<%-- 学生登録完了JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - 登録完了</title>
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
        
        /* 【変更】登録完了の緑色の背景帯メッセージ */
        .success-message-box { 
            background-color: #add8e6; /* 画像に合わせた落ち着いた緑色 */
            color: #ffcccb;            /* 濃い緑の文字色 */
            padding: 10px 15px; 
            font-size: 14px; 
            font-weight: bold;
            margin-bottom: 40px; 
            border-radius: 2px;
            max-width: 700px;          /* 前画面のフォーム幅と統一 */
        }
        
        /* 下部リンクエリア */
        .link-area { font-size: 14px; }
        .link-area a { text-decoration: none; color: #0056b3; font-weight: bold; margin-right: 20px; }
        .link-area a:hover { text-decoration: underline; }
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
            <div class="content-title">学生情報登録</div>

            <%-- 緑色の完了メッセージ帯 --%>
            <div class="success-message-box">
                登録が完了しました
            </div>

            <%-- 下部の遷移リンク --%>
            <div class="link-area">
                <a href="StudentCreate.action">戻る</a>
                <a href="StudentList.action">学生一覧</a>
            </div>
        </div>
    </div>

</body>
</html>
