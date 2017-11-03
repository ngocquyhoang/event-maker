class Event < ApplicationRecord
  belongs_to :user
  has_one :layout
  has_many :cost_management

  validate :start_time_validation
  validate :end_time_validation

  def start_time_validation
    if self.start_time.present? && self.start_time < Date.today
      errors.add(:start_time, "can't be in the past")
    end
  end

  def end_time_validation
    if self.end_time.present?
      if self.end_time < Date.today
        errors.add(:start_time, "can't be in the past")
      elsif self.start_time.present? && self.end_time < self.start_time
        errors.add(:start_time, "can't be less than start date")
      end
    end
  end
end
