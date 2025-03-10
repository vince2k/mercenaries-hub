class MercenariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # Devise s’assure que l’utilisateur est connecté avant d’accéder aux actions
  before_action :set_mercenary, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy] # Vérifie que l'utilisateur est propriétaire du mercenaire.

  def index
    @mercenaries = Mercenary.all

    # Recherche par nom (sans casser les autres filtres)
    if params[:query].present?
      @mercenaries = @mercenaries.where("name ILIKE ?", "%#{params[:query]}%")
    end

    # Génération des marqueurs pour la carte
    @markers = @mercenaries.geocoded.map do |mercenary|
      {
        lat: mercenary.latitude,
        lng: mercenary.longitude,
        info_window: render_to_string(partial: "info_window", locals: { mercenary: mercenary }),
        name: mercenary.name
      }
    end

    # Filtrage par spécialité
  if params[:specialty].present?
    @mercenaries = @mercenaries.where(specialty: params[:specialty])
  end

  # Filtrage par disponibilité (période sélectionnée)
  if params[:start_date].present? && params[:end_date].present?
    start_date = Date.parse(params[:start_date]) rescue nil
    end_date = Date.parse(params[:end_date]) rescue nil

    if start_date && end_date
      # Trouver les mercenaires qui n'ont AUCUNE réservation qui bloque la période sélectionnée
      reserved_mercenaries = Booking.where("start_date <= ? AND end_date >= ?", end_date, start_date).pluck(:mercenary_id)
      @mercenaries = @mercenaries.where.not(id: reserved_mercenaries)
    end
  end

  # Filtrer par disponibilité sur la plage de dates
  if params[:start_date].present? && params[:end_date].present?
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    booked_mercenary_ids = Booking.active
                                 .where("start_date <= ? AND end_date >= ?", end_date, start_date)
                                 .pluck(:mercenary_id)
    @mercenaries = @mercenaries.where.not(id: booked_mercenary_ids)
  end

  # Préparer toutes les dates réservées pour Flatpickr
  @all_booked_dates = Booking.active.flat_map do |b|
    (b.start_date..b.end_date).map { |d| d.strftime("%Y-%m-%d") }
  end.uniq

  # Tri par prix
  if params[:order] == "price_asc"
    @mercenaries = @mercenaries.order(price_per_day: :asc)
  elsif params[:order] == "price_desc"
    @mercenaries = @mercenaries.order(price_per_day: :desc)
  end

  # Tri par prix
  if params[:order] == "price_asc"
    @mercenaries = @mercenaries.order(price_per_day: :asc)
  elsif params[:order] == "price_desc"
    @mercenaries = @mercenaries.order(price_per_day: :desc)
  end

  # Tri par prix
  if params[:order] == "price_asc"
    @mercenaries = @mercenaries.order(price_per_day: :asc)
  elsif params[:order] == "price_desc"
    @mercenaries = @mercenaries.order(price_per_day: :desc)
  end

  # Génération des marqueurs pour la carte
  # Convertir les adresses en latitude/longitude si elles existent
  @markers = @mercenaries.geocoded.map do |mercenary|
    {
      lat: mercenary.latitude,
      lng: mercenary.longitude,
      info_window: render_to_string(partial: "info_window", locals: { mercenary: mercenary }),
      name: mercenary.name
    }
  end
end

  def new
    @mercenary = Mercenary.new
  end

  def create
    @mercenary = current_user.mercenaries.build(mercenary_params) # Associe directement le mercenaire à l’utilisateur connecté par devise.
    if @mercenary.save
      redirect_to my_mercenaries_mercenaries_path, notice: "Mercenaire ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # on accède d'abord aux bookings de mercenary
    @bookings = @mercenary.bookings
    # on itere sur les revues
    # .map car c'est un array
    @reviews = @bookings.map {|booking| booking.review}
    # on ignore celles qui sont vides
    @reviews = @reviews.reject { |review| review == nil }
    # @reviews = @mercenary.reviews if defined?(Review) # Charge les reviews si la table Review existe.
  end

  def edit
  end

  def update
    if @mercenary.update(mercenary_params)
      redirect_to @mercenary, notice: "Le profil du mercenaire a été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mercenary.destroy!
    redirect_to mercenaries_path, notice: "Le mercenaire a été supprimé avec succès.", status: :see_other
  end

  def my_mercenaries
    @mercenaries = current_user.mercenaries

    @markers = @mercenaries.geocoded.map do |mercenary|
      {
        lat: mercenary.latitude,
        lng: mercenary.longitude,
        info_window: render_to_string(partial: "info_window", locals: { mercenary: mercenary }),
        name: mercenary.name
      }
    end

    render :index
  end

  private

  def set_mercenary
    @mercenary = Mercenary.find(params[:id])
  end

  # Nouvelle méthode pour vérifier si l'utilisateur est propriétaire
  def authorize_user!
    redirect_to mercenaries_path unless current_user == @mercenary.user
  end

  def mercenary_params
    params.require(:mercenary).permit(:name, :bio, :picture, :price_per_day, :address, :specialty)
  end
end
