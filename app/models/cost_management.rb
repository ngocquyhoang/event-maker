class CostManagements < ApplicationRecord
  enum type: [:thu, :chi]
  belongs_to :user
  belongs_to :event
end
