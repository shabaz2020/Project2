class ArtistsController < ApplicationController

    def index
        @query = params[:query]
        if @query
            @artists = Artist.find_by_query(@query) 
        else
            @artists = Artist.all
        end

        if params[:sort] == "popularity"
            @artists = @artists.sort_by {|artist| artist.subscriptions.length}.reverse
        elsif params[:sort] == "a-z"
            @artists = @artists.sort_by {|artist| artist.name}
        elsif params[:sort] == "z-a"
            @artists = @artists.sort_by {|artist| artist.name}.reverse
        end
    end

    def show
        @artist = Artist.find(params[:id])
        @songs = @artist.songs
        @subscription = Subscription.find_by(artist:@artist, user:current_user)
    end
end
