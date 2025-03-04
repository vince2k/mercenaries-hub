class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :set_mercenary, only: [:new, :create, :edit, :update] # Définit @mercenary à partir de :mercenary_id
  before_action :set_booking, only: [:edit, :update, :destroy] # Définit @booking à partir de :id

  def index
    @bookings = current_user.bookings # Toutes les réservations de l'utilisateur connecté
    @recruitment_requests = Booking.joins(:mercenary).where(mercenaries: { user_id: current_user.id }).includes(:user)
  end

  def new
    @booking = @mercenary.bookings.build # Initialise avec le mercenaire
  end

  def create
    @booking = @mercenary.bookings.build(booking_params) # Associe au mercenaire
    @booking.user = current_user # Associe à l’utilisateur connecté via Devise

    if @booking.save
      redirect_to bookings_path, notice: "Réservation ajoutée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: "Le contrat a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # a booking can be canceled, then so are the reviews
  def destroy
    @booking.destroy!
    redirect_to bookings_path, notice: "La réservation a été annulée avec succès.", status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_mercenary
    @mercenary = Mercenary.find(params[:mercenary_id])
  end

  def booking_params
    params.require(:booking).permit(:mission_purpose, :mission_place, :start_date, :end_date)
  end
end
