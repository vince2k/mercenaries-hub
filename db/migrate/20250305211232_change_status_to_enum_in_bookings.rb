class ChangeStatusToEnumInBookings < ActiveRecord::Migration[7.1]
  def up
    # Supprime la colonne status booléenne
    remove_column :bookings, :status, :boolean

    # Ajoute une nouvelle colonne status de type integer avec une valeur par défaut (0)
    add_column :bookings, :status, :integer, default: 0, null: false

    # Optionnel : Mets à jour les enregistrements existants
    # Ancien false -> 0 (pending), ancien true -> 1 (assigned)
    Booking.where(status: false).update_all(status: 0)
    Booking.where(status: true).update_all(status: 1)
  end

  def down
    # Rollback : Remplace par un booléen
    remove_column :bookings, :status, :integer
    add_column :bookings, :status, :boolean, default: false

    # Restaure les valeurs booléennes
    Booking.where(status: 0).update_all(status: false)
    Booking.where(status: 1).update_all(status: true)
  end
end
