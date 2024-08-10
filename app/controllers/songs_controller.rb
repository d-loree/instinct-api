# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :authenticate_user!

  # GET /songs (all of the current user's songs)
  def index
    @songs = current_user.songs
    render json: @songs
  end

  # GET /songs/# (get a single song)
  def show
    @song = current_user.songs.find_by(id: params[:id]) || Song.where(privacy: 'public').find_by(id: params[:id])
    if @song.nil?
      render json: { error: 'Song does not exist or is private/owned by someone else' }, status: :not_found 
      return
    end
    render json: @song, status: :ok
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

  # DELETE /songs/#
  def destroy
    @song = current_user.songs.find_by(id: params[:id])
    if @song.nil?
      render json: { error: 'Song does not exist or does not belong to user' }, status: :not_found
      return
    end
    @song.destroy
    render json: @song, status: :ok
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :song_image, :audio_file, :privacy)
  end
end
