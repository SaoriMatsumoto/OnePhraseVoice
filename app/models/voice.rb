class Voice < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :file, presence: true, file_size: {maximum: 300.kilobytes.to_i} , on: :create
  validates :file, allow_blank: true , file_size: {maximum: 300.kilobytes.to_i} , on: :share
  validates :description, presence: true, length: { maximum: 140 }
  
  mount_uploader :file, VoiceUploader
  
  has_many :favorites, foreign_key: 'voice_id', dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  def favorite?(user)
    favorite_users.include?(user)
  end
  
  acts_as_taggable_on :labels
  acts_as_taggable
  
  has_many :comments, foreign_key: 'voice_id', dependent: :destroy
  
  belongs_to :original, class_name: "Voice", dependent: :destroy
end
