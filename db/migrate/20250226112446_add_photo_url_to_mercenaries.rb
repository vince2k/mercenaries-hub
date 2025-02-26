class AddPhotoUrlToMercenaries < ActiveRecord::Migration[7.1]
  def change
    add_column :mercenaries, :photo_url, :string
  end
end
