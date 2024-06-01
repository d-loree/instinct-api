class Song < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :artist, presence: true
end
