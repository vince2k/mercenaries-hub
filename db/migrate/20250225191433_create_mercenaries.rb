class CreateMercenaries < ActiveRecord::Migration[7.1]
  def change
    create_table :mercenaries do |t|
      t.string :name
      t.string :specialty
      t.string :bio
      t.integer :price_per_day
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
