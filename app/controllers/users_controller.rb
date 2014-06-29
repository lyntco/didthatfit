class UsersController < ApplicationController
  def index
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
    @user = User.new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :size, :email)
  end

end