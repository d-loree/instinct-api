class Playlist < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :songs

  validates :name, presence: true

  has_one_attached :playlist_image
end
