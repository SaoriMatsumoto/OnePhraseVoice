class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @voice = current_user.voices.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @q = Voice.search(params[:q])
      @voices = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
    else
      @ranking = Favorite.group(:voice_id).order('count_voice_id desc').limit(10).count('voice_id')
      voice_ids = @ranking.keys
      @voices = Voice.find(voice_ids).sort_by{ |o| voice_ids.index(o.id)}
    end
  end
end
