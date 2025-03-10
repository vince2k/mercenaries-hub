class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :mercenary
  has_one :review, dependent: :destroy

  has_one_attached :target_photo

   # Définition de l’enum pour status
   enum status: {
    pending: 0,          # "En attente de validation"
    assigned: 1,         # "Mission attribuée"
    cancelled: 2,        # "Mission annulée"
    in_progress: 3,      # "Mission en cours"
    over: 4,             # "Mission terminée, en attente du rapport"
    completed: 5,        # "Succès de la mission"
    failed: 6            # "Échec de la mission"
  }, _default: :pending  # Valeur par défaut

  # Scope pour les bookings actifs
  scope :active, -> { where.not(status: "cancelled") }

  STATUS_TEXT = {
    "pending" => "En attente de validation",
    "assigned" => "Mission attribuée",
    "cancelled" => "Mission annulée par l'employeur",
    "in_progress" => "Mission en cours",
    "over" => "Mission terminée, en attente du rapport",
    "completed" => "Succès de la mission",
    "failed" => "Échec de la mission"
  }.freeze

  validates :mission_purpose, presence: true
  validates :mission_place, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_after_start_date
  before_save :calculate_total_price
  # before_save :update_status  # Mise à jour automatique du statut

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

  # Méthode pour afficher le statut en texte lisible
  def status_text
    STATUS_TEXT[status]
  end

  # Méthode d'instance pour mettre à jour un booking spécifique
  # def update_status
  #   return unless start_date && end_date
  #   if status == "assigned" && Date.today >= start_date && Date.today <= end_date
  #     update(status: "in_progress")
  #   elsif status == "in_progress" && Date.today > end_date
  #     update(status: "over")
  #   end
  # end

  # Méthode de classe pour mettre à jour tous les bookings
  def self.update_all_statuses
    Booking.all.each do |booking|
      if booking.status == "assigned" && Date.today >= booking.start_date && Date.today <= booking.end_date
        booking.update(status: "in_progress")
      elsif booking.status == "pending" && Date.today > booking.start_date
        booking.update(status: "cancelled")
      elsif booking.status == "in_progress" && Date.today > booking.end_date
        booking.update(status: "over")
      end
    end
  end

  def toggle_status(new_status)
    return false unless status == "over"
    return false unless %w[completed failed].include?(new_status)
    update(status: new_status)
  end
end
