class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :set_mercenary, only: [:new, :create] # Définit @mercenary à partir de :mercenary_id

  def index
    @bookings = current_user.bookings # Toutes les réservations de l'utilisateur connecté
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

  # a booking can be canceled, then so are the reviews
  def destroy
  end

  private

  def set_mercenary
    @mercenary = Mercenary.find(params[:mercenary_id])
  end

  def booking_params
    params.require(:booking).permit(:mission_purpose, :mission_place, :start_date, :end_date)
  end
end
