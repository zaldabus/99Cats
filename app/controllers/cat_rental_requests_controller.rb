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

  # def destroy
#
#   end

end
