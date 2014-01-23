class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

      if @user.nil?
        render json: "WRONG CREDENTIALS!!!"
      else
        @user.reset_session_token!

        session[:session_token] = @user.session_token

        redirect_to cats_url
      end
  end

  def new
    render :new
  end

  def destroy
    session_token = session[:session_token]
    @user = User.find_by_session_token(session_token)

    session[:session_token] = nil
    @user.reset_session_token!

    redirect_to cats_url
  end
end
