class UsersController < ApplicationController
  before_action :check_if_logged_in, :except => [:new, :create]
  before_action :check_if_admin, :only => [:index]
  before_action :skip_password_attribute, only: :update

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
    @user = User.where(:username => params[:id]).first
  end

  def show
    @user = User.where(:username => params[:id]).first
  end

  def update
    # unless @current_user.is_admin? && params[:id] == 'edit'
      @user = User.where(:username => params[:id]).first
    # else
      # @user = @current_user
    # end
    # if @current_user.authenticate(params[:user][:current_password])
      # raise params.inspect
      @user.update user_params
      redirect_to( users_path )
    # else
      # flash[:notice] = "Your current password didn't match. Please try again"
      # render :edit
    # end

  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to( users_path )
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :avatar, :avatar_cache, :password, :password_confirmation, :size, :email)
  end

  def skip_password_attribute
    if params[:user][:password].blank? && params[:user][:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end

end