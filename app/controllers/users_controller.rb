class UsersController < ApplicationController
  before_action :check_if_logged_in, :except => [:new, :create]
  # before_action :check_if_admin, :only => [:index]

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params
    # raise params.inspect
    @user.username = @user.username.downcase # forces downcase username
    @user.avatar = "/assets/images/default_icon.jpg" #gives user default icon
    if @user.save
      session[:user_id] = @user.id
      redirect_to( root_path )
    else
      render :new
    end
  end

  def new
    # raise params.inspect
    @user = User.new
  end

  def edit
    @user = User.where(:username => params[:id]).first
    if params[:id] != @current_user.username && @current_user.is_admin? == false
      redirect_to( edit_user_path(@current_user.username) )
    end
  end

  def show
    @user = User.where(:username => params[:id]).first
  end

  def update
    @user = User.where(:username => params[:id]).first

    if @current_user.authenticate(params[:user][:current_password])
      @user.update user_params
      redirect_to( users_path )
    else
      flash[:notice] = "Your current password didn't match. Please try again"
      render :edit
    end

  end

  def destroy
    user = User.where(:username => params[:id]).first
    user.destroy
    redirect_to( users_path )
  end

  def follow
    user_to_add = User.where(:username => params[:id]).first
    @current_user.friends << user_to_add
    redirect_to( user_path( user_to_add.username) )
  end

  def unfollow
    # raise params.inspect
    user_to_remove = User.where(:username => params[:id]).first
    @current_user.friendships.where( :friend_id => user_to_remove.id ).first.destroy
    redirect_to( user_path( user_to_remove.username) )
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :avatar, :avatar_cache, :password, :password_confirmation, :size, :email)
  end

end