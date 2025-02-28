class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    # @booking = current_user.bookings.build(booking_params) # Associe directement le mercenaire à l’utilisateur connecté par devise

    @booking = Booking.new(booking_params)
    @booking.user = User.find(params[:booking][:user_id].to_i)
    @booking.mercenary = Mercenary.find(params[:mercenary_id])

    if @booking.save!
      # TODO redirect_to la show de l'utilisateur ?? = index de booking d'un utilisateur
      redirect_to root_path, notice: "Reservation ajoutée avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def total_price
  end

  def booking_params
    params.require(:booking).permit(:mission_purpose, :mission_place, :start_date, :end_date, :total_price, :mercenary_id, :user_id)
  end
end
