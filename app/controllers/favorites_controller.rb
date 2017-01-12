class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        @voice = Voice.find(params[:voice_id])
        current_user.favorite(@voice)
    end
    
    def destroy
        @voice = Voice.find(params[:voice_id])
        current_user.unfavorite(@voice)
    end
end
