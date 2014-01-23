module SessionsHelper

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def login_user!
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    session[:session_token] = @user.session_token

    redirect_to cats_url
  end

end
