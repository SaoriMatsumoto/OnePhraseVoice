class RankingsController < ApplicationController
    before_action :logged_in_user
    
    def show
        @ranking = Favorite.group(:voice_id).order('count_voice_id desc').limit(10).count('voice_id')
        voice_ids = @ranking.keys
        @voices = Voice.find(voice_ids).sort_by{ |o| voice_ids.index(o.id)}
        render 'show'
    end
end
