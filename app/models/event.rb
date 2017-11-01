class Event < ApplicationRecord
  belongs_to :user
  has_one :layout
  has_many :cost_management

  validates :start_time_validation
  validates :end_time_validation

  def start_time_validation
    if :start_time.present? && :start_time < Date.today
      errors.add(:start_time, "can't be in the past")
    end
  end

  def end_time_validation
    if :end_time.present?
      if :end_time < Date.today
        errors.add(:start_time, "can't be in the past")
      elsif :start_time.present? && :end_time < :start_time
        errors.add(:start_time, "can't be less than start date")
      end
    end
  end
end
