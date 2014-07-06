class UsersController < ApplicationController
  before_action :check_if_logged_in, :except => [:new, :create, :index,:show]
  # before_action :check_if_admin, :only => [:index]

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params
    # raise params.inspect
    @user.username = @user.username.downcase # forces downcase username
    @user.instagram_id = session[:instagram_id] if session[:instagram_id]
    if @user.save
      session[:user_id] = @user.id
      session[:instagram_id] = nil
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
    @user = User.find_by(:username => params[:id])
    if params[:id] != @current_user.username && @current_user.is_admin? == false
      redirect_to( edit_user_path(@current_user.username) )
    end
  end

  def show
    @user = User.find_by(:username => params[:id])
    @followers = Friendship.where(:friend_id => @user.id)
    if @user.items.any?
      @brands = @user.items.each {|i| i.brand }
    end
  end

  def update
    @user = User.find_by(:username => params[:id])

    if @current_user.authenticate(params[:user][:current_password]) || @current_user.is_admin?
      @user.update user_params
      if @current_user.is_admin?
        redirect_to( users_path )
      else
        redirect_to( user_path(@current_user.username))
      end
    else
      flash[:notice] = "Your current password didn't match. Please try again"
      redirect_to( edit_user_path(@current_user.username) )
    end
  end

  def make_admin
    user = User.find_by(:username => params[:id])
    if user.is_admin?
      user.is_admin = false
    else
      user.is_admin = true
    end
    user.save
    redirect_to( users_path )
  end

  def destroy
    user = User.find_by(:username => params[:id])
    user.destroy
    redirect_to( users_path )
  end

  def follow
    user_to_add = User.find_by(:username => params[:id])
    @current_user.friends << user_to_add
    redirect_to( user_path( user_to_add.username) )
  end

  def unfollow
    # raise params.inspect
    user_to_remove = User.find_by(:username => params[:id])
    friendship = @current_user.friendships.find_by( :friend_id => user_to_remove.id )
    friendship.destroy
    redirect_to( user_path( user_to_remove.username) )
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :avatar, :avatar_cache, :remote_avatar_url, :password, :password_confirmation, :size, :email)
  end

end