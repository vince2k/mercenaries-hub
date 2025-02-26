class User < ApplicationRecord
  has_many :mercenaries
  has_many :bookings
  validates :email, presence: true, uniqueness: true

  # voir si last_name first name et/ou nickname doivent être validés

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
