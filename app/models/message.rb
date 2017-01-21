class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :post_user , class_name: "User"
  validates :message, presence: true, length: { maximum: 10000 }
end
