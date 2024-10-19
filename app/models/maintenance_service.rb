class MaintenanceService < ApplicationRecord
  belongs_to :car

  enum status: { pending: 0, in_progress: 1, completed: 2 }

  validates :description, presence: true
  validates :date, presence: true, date: { on_or_before: :today }
end
