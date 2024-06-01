class SongsController < ApplicationController
    before_action :authenticate_user!

    def index
        @songs = current_user.songs
        render json: @songs
    end
    
    def create
        @song = current_user.songs.build(song_params)
        if @song.save
            render json: @song, status: :created
        else
            render json: @song.errors, status: :unprocessable_entity
        end
    end
    
    private
    
    def song_params
        params.require(:song).permit(:name, :artist)
    end
end
