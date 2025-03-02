class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :mercenary
  has_one :review

  validates :mission_purpose, presence: true
  validates :mission_place, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  # validate :end_date_after_start_date

# private

# def end_date_after_start_date
#   if end_date < start_date
#     # retourner message d'erreur
#   end
end
