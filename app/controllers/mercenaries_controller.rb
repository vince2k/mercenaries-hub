class MercenariesController < ApplicationController
  before_action :authenticate_user! # Devise s’assure que l’utilisateur est connecté avant d’accéder aux actions
  before_action :set_mercenary, only: %i[show edit update destroy]

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
    params.require(:mercenary).permit(:name, :bio, :photo_url, :price_per_day, :address, :specialty)
  end
end
