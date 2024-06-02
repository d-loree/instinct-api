class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 500 }

  has_many :playlists
  has_many :songs

  has_one_attached :profile_picture

  validates :profile_picture, content_type: ['image/png', 'image/jpg', 'image/jpeg'], 
  size: { less_than: 5.megabytes , message: 'is too large' }
end
