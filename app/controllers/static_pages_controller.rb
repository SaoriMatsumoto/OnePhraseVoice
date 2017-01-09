class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @voice = current_user.voices.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
