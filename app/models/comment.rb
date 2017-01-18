class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :voice
    validates :comment, presence: true, length: { maximum: 140 }
end