class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to cats_url
    else
      render @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new

    render :new
  end
end
