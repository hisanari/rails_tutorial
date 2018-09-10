module SessionsHelper
  # 渡されたユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン中のユーザーを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ユーザーがログイン状態かどうか返す
  def logged_in?
    !current_user.nil?
  end

  # ログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
