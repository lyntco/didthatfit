class SessionsController < ApplicationController
  def new
  end

  def fb_create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id # session is a private hash rails uses
    redirect_to root_path
  end

  def create
    # raise params.inspect
    user = User.find_by(:username => params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id # session is a private hash rails uses
      redirect_to root_path
    else
      # flash notice
      flash[:notice] = "Invalid login. Please try again"
      redirect_to login_path
    end
  end

  def destroy
    # raise params.inspect
    session[:user_id] = nil
    redirect_to root_path
  end

end