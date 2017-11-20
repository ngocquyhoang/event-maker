class Layout < ApplicationRecord
  validates :name, presence: true
  validates :event_types, presence: true
  validates :featured_image, presence: true
  validates :html, presence: true
  validates :css, presence: true

  mount_uploader :featured_image, Admin::FeaturedImageUploader
end
