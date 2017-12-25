require 'unicode_utils'

class Event < ApplicationRecord
  belongs_to :user
  belongs_to :event_type
  belongs_to :layout
  has_many :cost_managements

  validate :start_time_validation
  validate :end_time_validation

  validates :slug, uniqueness: true, presence: true, length: { in: 3..12 }
  validates :name, presence: true
  validates :user_id, presence: true
  validates :layout_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :main_description, presence: true
  validates :address, presence: true
  validates :event_type_id, presence: true
  validates :address_commune, presence: true
  validates :address_district, presence: true
  validates :address_province, presence: true
  validates :expense, presence: true
  validates :title_layout, presence: true
  validates :seo_keyword, presence: true

  before_save :clean_slug

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

  def clean_slug
    self.slug = UnicodeUtils.downcase("#{self.slug}", :tr).gsub(/[()-,. @*&$#^!']/, '')
  end

  def build_host
    cmd = "sudo virtualhost create " + self.slug + ".zevent.date"
    system(cmd)
    if $?.exitstatus == 0
      puts "Yay !! Create virtualhost successfully !"
    else
      puts "Oh noo!! OOP!"
    end
  end
end
