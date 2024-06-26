# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :artist, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :audio_file, presence: true
  validates :privacy, presence: true, inclusion: { in: %w[public private], message: "privacy value must be 'public' or 'private'" }

  has_one_attached :song_image
  has_one_attached :audio_file

  validates :song_image, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                         size: { less_than: 5.megabytes, message: 'is too large' }

  validates :audio_file, content_type: ['audio/mpeg', 'audio/mp3'],
                         size: { less_than: 10.megabytes, message: 'is too large' }
end
