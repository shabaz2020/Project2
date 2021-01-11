class PlaylistsController < ApplicationController
    before_action :get_playlist, only: [:show, :edit, :update, :destroy]

    def index
        @query = params[:query]
        if @query
            @playlists = Playlist.find_by_query(@query)
        else
            @playlists = Playlist.all
        end

        if params[:sort] == "popularity"
            @playlists = @playlists.sort_by {|playlist| playlist.favorites.count}.reverse
        elsif params[:sort] == "a-z"
            @playlists = @playlists.sort_by {|playlist| playlist.name.downcase}
        elsif params[:sort] == "z-a"
            @playlists = @playlists.sort_by {|playlist| playlist.name.downcase}.reverse
        end

    end

    def show
        @songs = @playlist.playlist_songs.map {|ps| ps.song }    
        @favorite = Favorite.find_by(playlist_id: params[:id], user_id: current_user.id)
    end
    
    def new
        @playlist = Playlist.new
    end

    def create
        @playlist = Playlist.new(user_id: current_user.id, name: params[:playlist][:name])
        if @playlist.save
            redirect_to @playlist
        else
            render :new
        end
    end

    def edit
        if !is_authorized?
            not_authorized
        end
    end

    def update
        if @playlist.update(name: params[:playlist][:name])
            redirect_to @playlist
        else 
            render :edit
        end
    end

    def destroy
        if !is_authorized?
            not_authorized
        else
            @playlist.destroy
            redirect_to playlists_path
        end
    end

    private

    def get_playlist
        @playlist = Playlist.find(params[:id])
    end

    def playlist_params
        params.require(:playlist).permit(:name, :user_id)
    end

    def is_authorized?
        @playlist.user == current_user
    end

    def not_authorized
        redirect_to playlists_path
        flash[:danger] = "You don't own this playlist!"
    end
end
