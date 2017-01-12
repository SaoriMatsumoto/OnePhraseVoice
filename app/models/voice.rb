class Voice < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  # validates :file, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  
  mount_uploader :file, VoiceUploader
  
  has_many :favorites, foreign_key: 'voice_id', dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite?(user)
    favorite_users.include?(user)
  end
end
