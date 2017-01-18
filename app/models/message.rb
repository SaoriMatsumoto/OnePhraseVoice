class Message < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true, length: { maximum: 10000 }
end
