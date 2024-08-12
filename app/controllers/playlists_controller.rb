# frozen_string_literal: true

class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist_and_song, only: %i[add_song remove_song]

  # GET /playlists (Returns current users playlists, but not with songs)
  def index
    @playlists = current_user.playlists
    render json: @playlists
  end

  # GET /playlists/# (Returns single playlist with songs in playlist)
  def show
    @playlist = current_user.playlists.find_by(id: params[:id]) || Playlist.where(privacy: 'public').find_by(id: params[:id])

    if @playlist.nil? 
      render json: { error: 'Playlist does not exist or is not public' }, status: :not_found
      return
    end

    # Filter songs that belong to the current user or are public
    @songs = @playlist.songs.where(user_id: current_user.id).or(@playlist.songs.where(privacy: 'public'))

    render json: @playlist.as_json.merge(songs: @songs)
  end

  # POST /playlists
  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      render json: @playlist, status: :created
    else
      render json: { error: 'Failed to create playlist' }, status: :unprocessable_entity
    end
  end

  # POST /playlists/#/add_song/#
  def add_song
    if @playlist.songs << @song
      render json: @playlist, status: :ok
    else
      render json: { error: 'Failed to add song to the playlist' }, status: :unprocessable_entity
    end
  end

  # DELETE /playlists/#/remove_song/#
  def remove_song
    if @playlist.songs.delete(@song)
      render json: @playlist, status: :ok
    else
      render json: { error: 'Failed to remove song from the playlist' }, status: :unprocessable_entity
    end
  end

  private

  def set_playlist_and_song
    @playlist = current_user.playlists.find_by(id: params[:id])
    @song = current_user.songs.find_by(id: params[:song_id]) || Song.where(privacy: 'public').find_by(id: params[:song_id])

    if @playlist.nil?
      render json: { error: 'Playlist does not exist or does not belong to current user' }, status: :not_found
      return
    end
    return unless @song.nil?

    render json: { error: 'Song does not exist' }, status: :not_found
    nil
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description, :playlist_image, :privacy)
  end
end
