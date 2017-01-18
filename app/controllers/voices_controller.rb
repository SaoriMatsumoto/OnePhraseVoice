class VoicesController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def index
        @voice = current_user.voices.build(voice_params)
        @voices = Voice.tagged_with(params[:tag]).order(created_at: :desc)
        render 'show_tag_list'
    end
    
    def show
        @voice = Voice.find(params[:id])
        @comment = Comment.new
        @comments = @voice.comments.order(created_at: :desc)
    end
    
    def create
        @voice = current_user.voices.build(voice_params)
        if @voice.save
            flash[:success] = "ボイスが投稿されました。"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def destroy
        @voice = current_user.voices.find_by(id: params[:id])
        return redirect_to root_url if @voice.nil?
        @voice.destroy
        flash[:success] = "削除されました。"
        redirect_to request.referrer || root_url
    end
    
    def share
       original = Voice.find(params[:id])
       @voice = current_user.voices.build(original_id: original.id)
       @voice.file = original.file
       @voice.description = "#{original.user.name}さんのボイス \n  #{original.description}"
        if @voice.save
            flash[:success] = "シェアされました。"
            redirect_to current_user
        else
            redirect_to :back
        end
    end
    
    def favorites_user
        @user = current_user
        @voice = Voice.find(params[:id])
        render 'users/show_favorites_user'
    end
    
    def create_comment
        @voice = Voice.find(params[:id])
        @comment = current_user.comments.build(voice_id: @voice.id,comment: params[:comment][:comment])
        @comment.save
        if @comment.save
            flash[:success] = "コメントを送信しました。"
            redirect_to @voice
        else
            @comments = @voice.comments.order(created_at: :desc)
            render 'show'
        end
    end
    
    private
    
    def voice_params
        params.require(:voice).permit(:file, :description, :tag_list)
    end
end
