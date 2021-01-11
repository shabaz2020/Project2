class SongsController < ApplicationController
    
    def index
        @playlist_id = params[:playlist_id]
        @query = params[:query]
        if params[:query]
            @songs = Song.find_by_query(params[:query]).to_a
            artists = Artist.find_by_query(params[:query])
            artist_songs = artists.map {|artist| artist.songs}.flatten
            artist_songs.each {|song| @songs << song}
            @songs = @songs.uniq
        else
            @songs = Song.all
        end

        if params[:sort] == "popularity"
            @songs = @songs.sort_by {|song| song.playlists.count}.reverse
        elsif params[:sort] == "a-z"
            @songs = @songs.sort_by {|song| song.title}
        elsif params[:sort] == "z-a"
            @songs = @songs.sort_by {|song| song.title}.reverse
        end
    end

    def show
       @song = Song.find(params[:id])
       if params[:playlist_id] && params[:playlist_id] !=""
        @playlist_id = params[:playlist_id]
       end
    end

end
