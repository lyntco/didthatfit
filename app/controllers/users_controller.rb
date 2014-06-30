class UsersController < ApplicationController
  # before_action :check_if_logged_in, :except => [:new, :create]
  # before_action :check_if_admin, :only => [:index]

  def index
    @users = User.all
  end

  def create
    @user = User.new user_params
    # raise params.inspect
    if @user.save
      @user.username.downcase! # forces downcase username
      @user.avatar = "/assets/images/default_icon.jpg" #gives user default icon
      @user.save
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
    @user = User.find params[:id]
  end

  def show
    @user = User.where(:username => params[:id]).first
  end

  def update
    @user = User.find params[:id]
    @user.update user_params
    redirect_to( users_path )
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to( users_path )
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :size, :email)
  end

end