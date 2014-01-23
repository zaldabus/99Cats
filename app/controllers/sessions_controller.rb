class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash[:errors] = "WRONG CREDENTIALS!!!"
      redirect_to new_session_url
    else
      session_token = SecureRandom::urlsafe_base64(16)

      session[:session_token] = session_token
      SessionToken.new(user_id: @user.id, token: session_token).save

      redirect_to cats_url
    end
  end

  def new
    render :new
  end

  def destroy
    session_token = session[:session_token]
    @user = current_user

    session[:session_token] = nil
    SessionToken.find_by_token(session_token).destroy

    redirect_to cats_url
  end
end
