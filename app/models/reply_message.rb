class ReplyMessage < ApplicationRecord
  belongs_to :message

  validates :content, presence: true
end
