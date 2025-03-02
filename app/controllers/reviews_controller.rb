class ReviewsController < ApplicationController
  def index
    @reviews = @mercenary.reviews # Toutes les revues du mercenaire
  end

  def new
    @review = @booking.reviews.build # Initialise avec le booking
  end

end
