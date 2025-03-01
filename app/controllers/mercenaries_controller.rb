class MercenariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] # Devise s’assure que l’utilisateur est connecté avant d’accéder aux actions
  before_action :set_mercenary, only: [:show, :edit, :update, :destroy]

  def index
    @mercenaries = Mercenary.all

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
  end

  def new
    @mercenary = Mercenary.new
  end

  def create
    @mercenary = current_user.mercenaries.build(mercenary_params) # Associe directement le mercenaire à l’utilisateur connecté par devise
    if @mercenary.save
      redirect_to root_path, notice: "Mercenaire ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reviews = @mercenary.reviews if defined?(Review) # Charge les reviews si la table Review existe
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


  private

  def set_mercenary
    @mercenary = Mercenary.find(params[:id])
  end

  def mercenary_params
    params.require(:mercenary).permit(:name, :bio, :picture, :price_per_day, :address, :specialty)
  end
end
