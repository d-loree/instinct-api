# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :authenticate_user!

  # GET /songs
  def index
    @songs = current_user.songs
    render json: @songs
  end

  # POST /songs
  def create
    @song = current_user.songs.build(song_params)
    if @song.save
      render json: @song, status: :created
    else
      render json: { error: 'Failed to create song' }, status: :unprocessable_entity
    end
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :song_image, :audio_file, :privacy)
  end
end
