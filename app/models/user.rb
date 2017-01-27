class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :location, length: { maximum: 50 }, allow_blank: true
    validates :profile, length: { maximum: 500 }, allow_blank: true
    validates :birthday, length: {maximum: 10 }, allow_blank: true
    
    mount_uploader :image, ImageUploader
    
    has_many :voices, dependent: :destroy
    has_many :voice_id, class_name: "Voice"
    
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end

    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    def following?(other_user)
        following_users.include?(other_user) 
    end
    
    def feed_items
        Voice.where(user_id: following_user_ids + [self.id])
    end
    
    has_many :favorites, foreign_key: 'user_id', dependent: :destroy
    has_many :favorite_voices, through: :favorites, source: :voice
    
    def favorite(voice)
       favorites.find_or_create_by(voice_id: voice.id) 
    end
    
    def unfavorite(voice)
       favorite = favorites.find_by(voice_id: voice.id)
       favorite.destroy if favorite
    end
    
    has_many :messages, foreign_key: 'user_id', dependent: :destroy
    
    has_many :comments, foreign_key: 'user_id', dependent: :destroy
end