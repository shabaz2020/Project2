class PlaylistSongsController < ApplicationController

    def new
        song_id = params[:song_id]
        if song_id && @song = Song.find_by_id(song_id)
            @playlist_song = @song.playlist_songs.build
            @playlists = Playlist.select{|ps| ps.user == current_user}
        else
            redirect_to songs_path
        end
    end

    def create
        @playlist_song = PlaylistSong.new(playlist_song_params)

        if !is_authorized?
            not_authorized
        else
            if @playlist_song.save
                redirect_to @playlist_song.playlist
            else
                render :new
            end
        end

    end

    def destroy
        @playlist_song = PlaylistSong.find(params[:id])
        if !is_authorized?
            not_authorized
        else
            @playlist = @playlist_song.playlist
            @playlist_song.destroy
            redirect_to @playlist
        end
    end

    private
    def playlist_song_params
        if params[:playlist_song]
            params.require(:playlist_song).permit(:playlist_id, :song_id)
        else
            params.permit(:playlist_id, :song_id)
        end
    end

    def is_authorized?
        @playlist_song.playlist.user == current_user
        
    end

    def not_authorized
        redirect_to playlists_path
        flash[:danger] = "You don't own this playlist!"
    end
end
