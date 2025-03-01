class AddAvailableToMercenaries < ActiveRecord::Migration[7.1]
  def change
    add_column :mercenaries, :available, :boolean, default: true
  end
end
