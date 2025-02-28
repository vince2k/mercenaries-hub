class MercenariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # Devise s’assure que l’utilisateur est connecté avant d’accéder aux actions

  def index
    @mercenaries = Mercenary.all
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

  private

  def mercenary_params
    params.require(:mercenary).permit(:name, :bio, :picture, :price_per_day, :address, :specialty)
  end
end
