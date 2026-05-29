<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - ログイン</title>
    <style>
        body { font-family: sans-serif; margin: 0; padding: 0; background-color: #ffffff; }
        
        /* 中央配置のためのコンテナスタイル */
        .login-layout { 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 75vh; 
            padding: 0 15px;
        }
        
        /* ログインカードのデザイン（全体デザインと調和する外枠） */
        .login-card { 
            width: 100%;
            max-width: 400px; 
            border: 1px solid #ccc; 
            background-color: #ffffff; 
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        /* カード上部のグレーヘッダーエリア */
        .card-header { 
            background-color: #dcdcdc; 
            padding: 12px; 
            font-size: 15px;
            font-weight: bold; 
            color: #333; 
            text-align: center;
            border-bottom: 1px solid #ccc;
            border-radius: 3px 3px 0 0;
        }
        
        /* フォームのコンテンツエリア */
        .card-body { padding: 30px 25px; }
        
        /* 各入力グループ */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; color: #333; margin-bottom: 6px; font-weight: bold; }
        
        /* 入力コントロール（科目・学生登録欄と共通の綺麗なフォーカス感） */
        .form-control { 
            width: 100%; 
            padding: 8px 10px; 
            border: 1px solid #b0d4ff; 
            background-color: #e8f0fe; 
            border-radius: 4px; 
            font-size: 14px;
            box-sizing: border-box;
        }
        
        /* パスワードを保存 チェックボックスの配置 */
        .checkbox-group { 
            margin-bottom: 25px; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            font-size: 13px; 
            color: #333; 
        }
        .checkbox-group input { margin-right: 6px; cursor: pointer; }
        .checkbox-group label { cursor: pointer; }
        
        /* エラーメッセージ（注意警告等と統一された薄赤のデザイン） */
        .error-message { 
            margin-bottom: 20px; 
            padding: 10px; 
            background-color: #f8d7da; 
            color: #721c24; 
            border: 1px solid #f5c6cb; 
            border-radius: 4px; 
            text-align: center; 
            font-size: 13px; 
        }
        
        /* ログインボタン（変更画面の保存等と合わせた鮮やかなブルー） */
        .btn-area { text-align: center; }
        .submit-btn { 
            width: 60%; 
            padding: 10px; 
            background-color: #007bff; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            font-weight: bold; 
            cursor: pointer; 
            font-size: 14px; 
        }
        .submit-btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>

    <%-- ヘッダーの読み込み --%>
    <jsp:include page="/header.jsp" />

    <div class="login-layout">
        <div class="login-card">
            <%-- ログインヘッダーエリア --%>
            <div class="card-header">
                ログイン
            </div>
            
            <%-- ログインフォーム本体 --%>
            <div class="card-body">
                <form action="LoginExecute.action" method="post">
                    
                    <%-- ユーザーID入力エリア --%>
                    <div class="form-group">
                        <label for="id">ID</label>
                        <input type="text" id="id" name="id" class="form-control" required autocomplete="username">
                    </div>
                    
                    <%-- パスワード入力エリア --%>
                    <div class="form-group">
                        <label for="password">パスワード</label>
                        <input type="password" id="password" name="password" class="form-control" required autocomplete="current-password">
                    </div>
                    
                    <%-- パスワードを保存 チェックボックス --%>
                    <div class="checkbox-group">
                        <input type="checkbox" id="rememberMe">
                        <label for="rememberMe">パスワードを保存</label>
                    </div>
                    
                    <%-- エラーメッセージ表示 --%>
                    <c:if test="${not empty message}">
                        <div class="error-message">
                            ${message}
                        </div>
                    </c:if>
                    
                    <%-- ログインボタン --%>
                    <div class="btn-area">
                        <button type="submit" class="submit-btn">ログイン</button>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>

</body>
</html>

