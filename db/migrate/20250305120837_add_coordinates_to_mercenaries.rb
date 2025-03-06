class AddCoordinatesToMercenaries < ActiveRecord::Migration[7.1]
  def change
    add_column :mercenaries, :latitude, :float
    add_column :mercenaries, :longitude, :float
  end
end
