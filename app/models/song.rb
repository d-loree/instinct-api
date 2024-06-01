class Song < ApplicationRecord
  belongs_to :user
  belongs_to :playlist, optional: true

  validates :name, presence: true
  validates :artist_name, presence: true
end
