class Voice < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  # validates :file, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  
  mount_uploader :file, VoiceUploader
end
