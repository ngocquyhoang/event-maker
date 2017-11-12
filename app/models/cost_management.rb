class CostManagement < ApplicationRecord
  enum cost_type: [:thu, :chi]
  belongs_to :user
  belongs_to :event
end
