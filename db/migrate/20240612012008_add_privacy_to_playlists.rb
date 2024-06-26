# frozen_string_literal: true

class AddPrivacyToPlaylists < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :privacy, :string, null: false, default: 'public'
  end
end
