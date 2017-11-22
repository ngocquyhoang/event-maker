class EventType < ApplicationRecord
  validates :label, presence: true
end
