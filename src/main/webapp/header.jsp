<%@page contentType="text/html; charset=UTF-8" %>
<style>
    .header-nav {
        background-color: #333;
        padding: 10px 20px;
        display: flex;
        justify-content: flex-end; /* 👈 右側のLog outボタンを右端に寄せる */
        align-items: center;
        min-height: 40px;          /* 縦方向のズレを防ぐための高さ確保 */
        position: relative;        /* 👈 中央配置の基準線にする */
    }
    .header-nav ul {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        color: white;
        font-size: 20px;
        
        /* 💡 以下の4行で画面の真ん中に強制配置します */
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
    .header-nav a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        font-size: 14px;
    }
    .header-nav a:hover {
        color: #ccc;
    }
</style>

<nav class="header-nav">
    <ul>
        得点管理システム
    </ul>
    <div>
        <a href="${pageContext.request.contextPath}/auth/Logout.action">Log out</a>
    </div>
</nav>
