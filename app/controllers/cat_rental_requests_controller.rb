class CatRentalRequestsController < ApplicationController

  def create
    @cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])

    if @cat_rental_request.save
      redirect_to cats_url
    else
      render @cat_rental_request.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @cats = Cat.all
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

end
