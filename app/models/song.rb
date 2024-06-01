class Song < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :artist, presence: true
  validates :audio_file, presence: true

  has_one_attached :song_image
  has_one_attached :audio_file
end
