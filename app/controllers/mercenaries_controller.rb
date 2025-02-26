class MercenariesController < ApplicationController
  def new
    @mercenary = Mercenary.new
  end

  def create
    @mercenary = Mercenary.new(mercenary_params)
    @mercenary.user = User.first # TEMPORAIRE : Associer au premier user en base

    if @mercenary.save
      redirect_to root_path, notice: "Mercenaire ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def mercenary_params
    params.require(:mercenary).permit(:name, :bio, :photo_url, :price_per_day, :address, :specialty)
  end
end
