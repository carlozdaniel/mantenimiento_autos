class MaintenanceService < ApplicationRecord
  belongs_to :car

  enum status: { pending: 0, in_progress: 1, completed: 2 }

  validates :description, presence: true
  validates :date, presence: true
  validate :date_must_be_in_the_past_or_present

  private

  def date_must_be_in_the_past_or_present
    if date.present? && date > Date.today
      errors.add(:date, "no puede estar en el futuro")
    end
  end
end
