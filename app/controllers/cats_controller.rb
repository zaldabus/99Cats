class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    render new_cat_url
  end

  def create
    @cat = Cat.new(params[:cat])

    if @cat.save
      redirect_to cats_url
    else
      render @cat.errors.full_messages, status: :unprocessable_entity
    end
  end

end
