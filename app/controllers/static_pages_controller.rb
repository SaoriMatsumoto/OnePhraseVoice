class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @voice = current_user.voices.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @q = Voice.search(params[:q])
      @voices = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
