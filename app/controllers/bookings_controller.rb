class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :toggle_status, :assign, :cancel]
  before_action :set_mercenary, only: [:new, :create, :edit, :update] # Définit @mercenary à partir de :mercenary_id
  before_action :set_booking, only: [:edit, :update, :destroy, :toggle_status, :assign, :cancel] # Définit @booking à partir de :id

  def index
    Booking.update_all_statuses # Met à jour tous les statuts des réservations
    @bookings = current_user.bookings.order(start_date: :asc) # Toutes les réservations de l'utilisateur connecté ordonnées par date de début
    @recruitment_requests = Booking.joins(:mercenary).where(mercenaries: { user_id: current_user.id }).includes(:user).order(start_date: :asc)
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

  def assign
    if @booking&.pending? && @booking.update(status: "assigned")
      redirect_to bookings_path, notice: "Mission assignée avec succès."
    else
      flash.now[:alert] = "Impossible d’assigner la mission."
      render :index, status: :unprocessable_entity
    end
  end

  def cancel
    if @booking&.pending? && @booking.update(status: "cancelled")  # Ou "failed" si pas de "cancelled"
      redirect_to bookings_path, notice: "Mission annulée avec succès."
    else
      flash.now[:alert] = "Impossible d’annuler la mission."
      render :index, status: :unprocessable_entity
    end
  end

  def toggle_status
    new_status = params[:new_status]
    if @booking.toggle_status(new_status)
      redirect_to bookings_path, notice: "Statut mis à jour avec succès."
    else
      flash.now[:alert] = "Impossible de mettre à jour le statut."
      render :index, status: :unprocessable_entity
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
    params.require(:booking).permit(:mission_purpose, :mission_place, :start_date, :end_date, :target_photo, :status)
  end
end
