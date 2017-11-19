class EventType < ApplicationRecord
  validates :label, presence: true
  
  # has_many :events
end
