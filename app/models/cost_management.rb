class CostManagement < ApplicationRecord
  enum cost_type: [:income, :cost]

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :note, presence: true
  validates :amount, presence: true
  validates :cost_type, presence: true

  belongs_to :user
  belongs_to :event
end
