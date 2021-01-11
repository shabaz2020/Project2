class SubscriptionsController < ApplicationController

    def create
        @subscription = current_user.subscriptions.build(artist_id:params[:artist_id])
        @subscription.save
        @artist = @subscription.artist
        redirect_to @artist
    end

    def destroy
        @subscription = Subscription.find(params[:id])
        @artist = @subscription.artist
        @subscription.destroy
        redirect_to @artist
    end



end
