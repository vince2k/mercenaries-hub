class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :mercenary
  has_one :review

  validates :mission_purpose, presence: true
  validates :mission_place, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_after_start_date
  before_save :calculate_total_price
end

def end_date_after_start_date
  return unless start_date && end_date
  if end_date < start_date
    errors.add(:end_date, "doit être après la date de début")
  end
end

def calculate_total_price
  return unless start_date && end_date && mercenary&.price_per_day
  days = (end_date - start_date).to_i + 1
  self.total_price = days * mercenary.price_per_day
end
