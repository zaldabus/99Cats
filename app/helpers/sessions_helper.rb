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

  def require_current_user!
    if params[:controller] == "cat_rental_requests"
      @cat = CatRentalRequest.find(params[:id]).cat
    elsif params[:controller] == "cats"
      @cat = Cat.find(params[:id])
    end

    redirect_to cats_url if @cat.user_id != current_user.id
  end


end
