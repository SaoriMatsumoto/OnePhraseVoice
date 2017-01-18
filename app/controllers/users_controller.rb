class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :favorites]
  before_action :only_current_user, only: [:edit, :update]
  
  def show
    @voices = @user.voices.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。ログインしてください。"
      redirect_to login_path
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
  
  def followings
    @users = @user.following_users
    render 'show_followings'
  end
  
  def followers
    @users = @user.follower_users
    render 'show_followers'
  end
  
  def favorites
    @voices = @user.favorite_voices.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_favorites'
  end
  
  def message_form
    @user = User.find(params[:id])
    @message = Message.new
    render 'message_form'
  end
  
  def create_message
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @messages = @user.messages.order(created_at: :desc).page(params[:page]).per(10)
    render 'show_messages'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile,
                                 :location, :birthday)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def only_current_user
    redirect_to root_path if current_user != @user
  end
end
