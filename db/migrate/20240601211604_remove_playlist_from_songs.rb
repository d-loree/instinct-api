class RemovePlaylistFromSongs < ActiveRecord::Migration[7.1]
  def change
    remove_reference :songs, :playlist, null: false, foreign_key: true
  end
end
