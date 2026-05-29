package auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class LogoutAction extends Action {

    @Override
    public void execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        // 現在のセッションを取得（存在しない場合はnullを返す）
        HttpSession session = request.getSession(false);

        if (session != null) {
            // セッションを破棄（ログイン情報を削除）
            session.invalidate();
        }

        // ログアウト完了画面（またはログイン画面）へフォワード
        // login.jspがwebapp直下にある場合
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }
}
