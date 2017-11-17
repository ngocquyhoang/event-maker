class AdminEmail < ApplicationRecord
  validates :to_email, presence: true
  validates :subject, presence: true
  validates :email_body, presence: true
end
