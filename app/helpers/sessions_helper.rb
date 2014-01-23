module SessionsHelper

  def current_user
    if SessionToken.find_by_token(session[:session_token])
      SessionToken.find_by_token(session[:session_token]).user
    else
      nil
    end
  end

  def login_user!
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )

    session_token = SecureRandom::urlsafe_base64(16)

    session[:session_token] = session_token
    SessionToken.new(user_id: @user.id, token: session_token).save

    redirect_to cats_url
  end

  def require_current_user!
    if params[:controller] == "cat_rental_requests"
      @cat = CatRentalRequest.find(params[:id]).cat
    elsif params[:controller] == "cats"
      @cat = Cat.find(params[:id])
    end

    redirect_to cats_url if @cat.user_id != current_user.id
  end


end
