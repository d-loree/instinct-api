# frozen_string_literal: true

class AddPrivacyToSongs < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :privacy, :string, null: false, default: 'public'
  end
end
