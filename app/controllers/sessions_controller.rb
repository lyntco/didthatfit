class SessionsController < ApplicationController
  def new
  end

  def instagram
    redirect_to(Instagram.authorize_url(:redirect_uri => CALLBACK_URL))
  end

  def instagram_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL) # => a hash inside a hash {:access_token=> "",:user => {:id => "", :username => ""} }
    session[:access_token] = response.access_token
    already_linked_user = User.find_by(:instagram_id => response.user.id)
    if session[:user_id].nil? && already_linked_user #if signed out and linked w/ instagram
      session[:user_id] = already_linked_user.id #sign in with id
      redirect_to(root_path)
    elsif @current_user && already_linked_user.nil? # if logged in but not linked to instagram
      @current_user.instagram_id = response.user.id
      @current_user.save
      redirect_to( edit_user_path( @current_user.username) )
    elsif @current_user && already_linked_user # to unlink instagram
      # binding.pry
      @current_user.instagram_id = nil
      @current_user.save
      # raise "skdjalksdj"
      redirect_to( edit_user_path( @current_user.username) )
    else
      redirect_to( new_user_path )
    end
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