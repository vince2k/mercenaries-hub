class Mercenary < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  has_one_attached :picture

  validates :name, :specialty, :price_per_day, presence: true
end
