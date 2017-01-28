class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :favorites,
                                  :message_form, :create_message, :show_message, :comments, :posted_favorites]
  before_action :only_current_user, only: [:edit, :update, :destroy, :show_message, :comments, :posted_favorites]
  before_action :logged_in_user, only: [:show, :followings, :followers, :favorites, :message_form, :create_message]
  before_action :unread_items, only: [:show, :followings, :followers, :favorites, :show_message, :comments, :posted_favorites]
  
  def show
    @voices = @user.voices.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render 'new'
    end  
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "削除されました。"
    redirect_to root_path
  end
  
  def followings
    @users = @user.following_users.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_followings'
  end
  
  def followers
    @user.follower_relationships.update_all(read_flg: 1) if @user == current_user
    @users = @user.follower_users.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_followers'
  end
  
  def favorites
    @voices = @user.favorite_voices.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_favorites'
  end
  
  def posted_favorites
    @favorites = Favorite.where(voice_id: current_user.voice_id)
    @favorites.update_all(read_flg: 1)
    @posted_favorites = @favorites.order(created_at: :desc).page(params[:page]).per(10)
    render "show_posted_favorites"
  end
  
  def message_form
    @message = Message.new
    render 'message_form'
  end
  
  def create_message
    @message = @user.messages.build(message: params[:message][:message])
    @message.post_user_id = current_user.id
    @message.save
    if @message.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to message_form_user_path
    else
      render 'message_form'
    end
  end
  
  def show_message
    @user.messages.update_all(read_flg: 1)
    @messages = @user.messages.order(created_at: :desc).page(params[:page]).per(5)
    render 'show_messages'
  end
  
  def comments
    @comments = Comment.where(voice_id: @user.voice_id)
    @comments.update_all(read_flg: 1)
    @for_user_comments = @comments.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_comments'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile,
                                 :location, :birthday, :image, :image_cache)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def only_current_user
    redirect_to root_path if current_user != @user
  end
  
  def unread_items
    @new_messages = Message.where(user_id: current_user.id, read_flg: 0)
    @new_followers = Relationship.where(followed_id: current_user.id, read_flg: 0)
    @new_comments = Comment.where(voice_id: current_user.voice_id, read_flg: 0)
    @new_favorites = Favorite.where(voice_id: current_user.voice_id, read_flg: 0)
  end
end
