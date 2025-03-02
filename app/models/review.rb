class Review < ApplicationRecord
  belongs_to :booking, dependent: :destroy

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
