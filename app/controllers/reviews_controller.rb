class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :new, :create]
  before_action :set_booking, only: [:new, :create, :edit] # Définit @booking à partir de :booking_id
  before_action :set_review, only: [:edit, :update, :destroy] # Définit @review à partir de :id

  def index
    @reviews = Review.all # Toutes les revues
  end

  def new
    # alternative à la ligne @review = @booking.build_review
    @review = Review.new

    # @review = @booking.build_review #  @booking.build_review # Initialise avec le booking
  end

  def show
  end

  def create
    @review = Review.new(review_params)
    @review.booking = @booking
    # on part du booking puis on cree lka revue, alternative aux deux lignes plus haut: @review = @booking.build_review(review_params)
    # @review = @booking.build_review(review_params)
    if @review.save
      redirect_to bookings_path, notice: "Avis ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
    # @review = @booking.build(review_params) # Associe au booking
    # @review.user = current_user # Associe à l’utilisateur connecté via Devise

    # # doit-on avoir un index de tout les avis que nous avons donné ?
    # if @review.save
    #   redirect_to bookings_path, notice: "Avis ajouté avec succès !"
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to bookings_path, notice: "L'avis a été modifié avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy!
    redirect_to bookings_path, notice: "L'avis a été supprimé avec succès.", status: :see_other
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

  # pour l'edition des avis, TODO plus tard
  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
