class FavoritesController < ApplicationController

    def create
        favorite = current_user.favorites.build(playlist_id: params[:playlist_id])
        favorite.save
        playlist = Playlist.find(params[:playlist_id])
        if params[:toggle]
            redirect_to playlist
        else
            redirect_to playlists_path
        end
        
    end

    def destroy
        favorite = Favorite.all.find(params[:id])
        playlist = favorite.playlist
        favorite.delete
        if params[:toggle]
            redirect_to playlist
        else
            redirect_to playlists_path
        end
    end

end
