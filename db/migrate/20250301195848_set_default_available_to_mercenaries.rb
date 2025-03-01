class SetDefaultAvailableToMercenaries < ActiveRecord::Migration[7.1]
  def change
    change_column_default :mercenaries, :available, from: nil, to: true
  end
end
