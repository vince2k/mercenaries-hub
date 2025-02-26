class User < ApplicationRecord
  has_many :mercenaries
  has_many :bookings
  # voir si last_name first name et/ou nickname doivent être validés

  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
