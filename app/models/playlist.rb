# frozen_string_literal: true

class Playlist < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :songs

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :privacy, presence: true, inclusion: { in: %w[public private], message: "privacy value must be 'public' or 'private'" }

  has_one_attached :playlist_image

  validates :playlist_image, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                             size: { less_than: 5.megabytes, message: 'is too large' }
end
