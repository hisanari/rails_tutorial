class SessionsController < ApplicationController
  def new
  end

  def create
    # ログインページより送られてきた情報より検索
    @user = User.find_by(email: params[:session][:email].downcase)
    # userが存在する　かつ　パスワードが正しい
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      # ログイン記憶
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = '無効なアドレス、またはパスワードです。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
