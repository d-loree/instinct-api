class PlaylistsController < ApplicationController
    before_action :authenticate_user!

    def index
        @playlists = current_user.playlists
        render json: @playlists
    end
    
    def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
        render json: @playlist, status: :created
    else
        render json: @playlist.errors, status: :unprocessable_entity
    end
    end
    
    def add_song
        @playlist = current_user.playlists.find(params[:id])
        @song = current_user.songs.find(params[:song_id])

        if @playlist.songs << @song
            render json: @playlist, status: :ok
        else
            render json: @playlist.errors, status: :unprocessable_entity
        end
    end
    
    def remove_song
        @playlist = current_user.playlists.find(params[:id])
        @song = @playlist.songs.find(params[:song_id])

        if @playlist.songs.delete(@song)
            render json: @playlist, status: :ok
        else
            render json: @playlist.errors, status: :unprocessable_entity
        end
    end
    
    private
    
    def playlist_params
        params.require(:playlist).permit(:name, :description)
    end
end
