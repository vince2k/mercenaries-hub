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
    @booked_dates = booked_dates_for_mercenary
  end

  def create
    @booking = @mercenary.bookings.build(booking_params) # Associe au mercenaire
    @booking.user = current_user # Associe à l’utilisateur connecté via Devise

    if @booking.save
      redirect_to bookings_path, notice: "Réservation ajoutée avec succès !"
    else
      @booked_dates = booked_dates_for_mercenary
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booked_dates = booked_dates_for_mercenary(exclude_booking: @booking)
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: "Le contrat a été mis à jour avec succès."
    else
      @booked_dates = booked_dates_for_mercenary(exclude_booking: @booking)
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

  def booked_dates_for_mercenary(exclude_booking: nil)
    # Ne prendre que les bookings actifs (exclut cancelled)
  bookings = @mercenary.bookings.where.not(status: "cancelled")
    return [] if bookings.empty?

    bookings = bookings.where.not(id: exclude_booking.id) if exclude_booking
    bookings.flat_map do |b|
      if b.start_date && b.end_date
        (b.start_date..b.end_date).map { |d| d.strftime("%Y-%m-%d") }
      else
        Rails.logger.error "Booking #{b.id} has invalid dates: start_date=#{b.start_date}, end_date=#{b.end_date}"
        []
      end
    end.uniq
  end
end
