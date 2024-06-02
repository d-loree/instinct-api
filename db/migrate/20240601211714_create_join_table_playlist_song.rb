# frozen_string_literal: true

class CreateJoinTablePlaylistSong < ActiveRecord::Migration[7.0]
  def change
    create_join_table :playlists, :songs do |t|
      t.index %i[playlist_id song_id]
      t.index %i[song_id playlist_id]
    end
  end
end
