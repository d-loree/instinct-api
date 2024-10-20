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

  # GET /public_songs  returns all the public songs, including users' public ones
  def public_songs
    # Fetch only public songs directly from the database
    public_songs = Song.where(privacy: 'public')

    if public_songs.empty?
      render json: { error: 'No public songs found' }, status: :not_found 
      return
    end

    render json: public_songs, status: :ok
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

  # PATCH /song/:id
  def update
    @song = current_user.songs.find_by(id: params[:id])
    if @song.update(song_params)
      render json: @song, status: :ok
    else
      render json: { error: 'Failed to update song' }, status: :unprocessable_entity
    end
  end

  private

  def song_params
    params.require(:song).permit(:name, :artist, :song_image, :audio_file, :privacy)
  end
end
