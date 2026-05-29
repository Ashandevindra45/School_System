<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - ログアウト完了</title>
    <style>
        body { font-family: sans-serif; margin: 0; padding: 0; background-color: #ffffff; }
        
        /* メインレイアウト（左メニューは無いため中央寄せまたは幅制限コンテンツ） */
        .logout-layout { max-width: 1200px; margin: 40px auto; padding: 0 30px; min-height: 400px; }
        .content-title { background-color: #f0f0f0; padding: 8px 15px; font-size: 14px; font-weight: bold; margin-bottom: 25px; color: #333; border-radius: 2px; }
        
        /* 他の完了画面と統一したメッセージボックスのスタイル */
        .info-message-box { 
            background-color: #e2e3e5; /* 落ち着いたライトグレー */
            color: #383d41;            /* 濃いグレーの文字色 */
            padding: 12px 15px; 
            font-size: 14px; 
            font-weight: bold;
            margin-bottom: 40px; 
            border-radius: 2px;
            border-left: 5px solid #6c757d; /* アクセントのグレー線 */
            max-width: 600px;
        }
        
        /* ログインリンクのスタイル */
        .link-area { font-size: 14px; }
        .link-area a { text-decoration: none; color: #0056b3; font-weight: bold; }
        .link-area a:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <%-- 【解決】ヘッダーの読み込みパスを他の画面と統一 --%>
    <jsp:include page="/header.jsp" />
    
    <div class="logout-layout">
        <%-- メインタイトル帯 --%>
        <div class="content-title">ログアウト</div>

        <%-- 案内メッセージボックス --%>
        <div class="info-message-box">
            ログアウトしました。
        </div>

        <%-- 再ログインリンク --%>
        <div class="link-area">
            <a href="Login.action">再度ログインする</a>
        </div>
    </div>

</body>
</html>
