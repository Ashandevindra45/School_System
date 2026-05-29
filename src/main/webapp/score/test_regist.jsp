<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績登録 - 得点管理システム</title>
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
        .search-container { border: 1px solid #ddd; border-radius: 4px; padding: 15px 20px; margin-bottom: 25px; background-color: #ffffff; display: flex; align-items: flex-end; gap: 15px; }
        
        .form-group { display: flex; flex-direction: column; gap: 4px; }
        .form-group label { font-size: 11px; color: #666; }
        
        .search-container select { padding: 6px; width: 120px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; background-color: #fff; }
        
        /* 検索ボタン（学生管理・成績参照画面の検索ボタンと統一） */
        .search-btn { padding: 6px 16px; background-color: #555; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; }
        .search-btn:hover { background-color: #333; }
        
        /* メッセージ表示（エラー等） */
        .message { color: red; font-size: 13px; font-weight: bold; margin-bottom: 15px; }
        
        /* 選択中の科目・回数表示 */
        .current-info { font-size: 14px; margin-top: 25px; margin-bottom: 15px; color: #333; }
        
        /* 成績登録テーブル（網目を廃止し、下線のみのモダンスタイルへ） */
        .score-table { width: 100%; border-collapse: collapse; font-size: 14px; margin-top: 5px; max-width: 800px; }
        .score-table th { text-align: left; padding: 10px 8px; border-bottom: 1px solid #999; color: #000; font-weight: bold; white-space: nowrap; }
        .score-table td { padding: 10px 8px; border-bottom: 1px solid #ddd; color: #333; vertical-align: middle; }
        
        /* 点数入力ボックス */
        .point-input { width: 80px; padding: 6px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; box-sizing: border-box; }
        
        /* 登録して終了ボタン（学生登録画面などのグレー四角ボタンと統一） */
        .btn-area { margin-top: 30px; margin-bottom: 15px; }
        .submit-btn { 
            padding: 8px 20px; background-color: #5a5a5a; color: white; border: none; 
            border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: bold; 
        }
        .submit-btn:hover { background-color: #444; }
        
        /* 戻るリンク */
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
                    <a href="${pageContext.request.contextPath}/score/TestRegist.action" style="font-weight: bold;">成績管理</a>
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/score/TestRegist.action" style="font-weight: bold;">成績登録</a></li>
                        <li><a href="${pageContext.request.contextPath}/score/TestList.action">成績参照</a></li>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/subject/SubjectList.action">科目管理</a></li>
            </ul>
        </div>

        <%-- 右側メインコンテンツ --%>
        <div class="content">
            <div class="content-title">成績登録</div>

            <%-- エラーまたは通知メッセージの表示 --%>
            <c:if test="${not empty message}">
                <p class="message">${message}</p>
            </c:if>

            <%-- 検索条件指定フォーム（成績参照画面のスタイルと統一） --%>
            <form action="TestRegist.action" method="get" class="search-container">
                <div class="form-group">
                    <label>入学年度</label>
                    <select name="f1">
                        <option value="0">--------</option>
                        <c:forEach var="year" items="${ent_year_set}">
                            <option value="${year}" <c:if test="${year == f1}">selected</c:if>>${year}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>クラス</label>
                    <select name="f2">
                        <option value="0">--------</option>
                        <c:forEach var="classNum" items="${class_num_set}">
                            <option value="${classNum}" <c:if test="${classNum == f2}">selected</c:if>>${classNum}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>科目</label>
                    <select name="f3">
                        <option value="0">--------</option>
                        <c:forEach var="subject" items="${subject_set}">
                            <option value="${subject.cd}" <c:if test="${subject.cd == f3}">selected</c:if>>${subject.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>回数</label>
                    <select name="f4">
                        <option value="0">--------</option>
                        <option value="1" <c:if test="${f4 == 1}">selected</c:if>>1回目</option>
                        <option value="2" <c:if test="${f4 == 2}">selected</c:if>>2回目</option>
                    </select>
                </div>

                <button type="submit" class="search-btn">検索</button>
            </form>

            <%-- 成績入力フォーム (検索結果がある場合のみ表示) --%>
            <c:if test="${not empty tests}">
                <div class="current-info">
                    科目：<strong>${subject.name}</strong> （${f4}回目）
                </div>
                
                <form action="TestRegistExecute.action" method="post">
                    <input type="hidden" name="subject_cd" value="${f3}">
                    <input type="hidden" name="num" value="${f4}">

                    <table class="score-table">
                        <thead>
                            <tr>
                                <th style="width: 30%;">学籍番号</th>
                                <th style="width: 45%;">氏名</th>
                                <th style="width: 25%;">点数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.student.no}</td>
                                    <td>${test.student.name}</td>
                                    <td>
                                        <input type="hidden" name="student_no_list" value="${test.student.no}">
                                        <input type="number" name="point_${test.student.no}" 
                                               value="${test.point >= 0 ? test.point : ''}" 
                                               class="point-input" min="0" max="100" required>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <%-- 登録ボタン（学生登録画面等の「登録して終了」ボタンのグレーデザインと共通化） --%>
                    <div class="btn-area">
                        <button type="submit" class="submit-btn">登録して終了</button>
                    </div>
                </form>
            </c:if>

            <%-- 下部の遷移リンク --%>
            <div style="margin-top: 30px;">
               <a href="${pageContext.request.contextPath}/auth/Menu.action" class="back-link">メニューに戻る</a>
            </div>
        </div>
    </div>

</body>
</html>
