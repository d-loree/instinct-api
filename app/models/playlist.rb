class Playlist < ApplicationRecord
  belongs_to :user
  has_many :songs

  validates :name, presence: true
end
