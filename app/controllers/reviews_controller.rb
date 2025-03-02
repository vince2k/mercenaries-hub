class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :set_booking, only: [:new, :create] # Définit @booking à partir de :booking_id

  def index
    @reviews = @booking.mercenary.reviews # Toutes les revues du mercenaire
  end

  def new
    @review = @booking.reviews.build # Initialise avec le booking
  end

  def create
    @review = @booking.mercenary.build(review_params) # Associe au booking
    @review.user = current_user # Associe à l’utilisateur connecté via Devise

    # doit-on avoir un index de tout les avis que nous avons donné ?
    if @review.save
      redirect_to reviews_path, notice: "Avis ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # à titre d'exemple la méthode create dans le controlleur booking
  # def create
  #   @booking = @mercenary.bookings.build(booking_params) # Associe au mercenaire
  #   @booking.user = current_user # Associe à l’utilisateur connecté via Devise

  #   if @booking.save
  #     redirect_to bookings_path, notice: "Réservation ajoutée avec succès !"
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
