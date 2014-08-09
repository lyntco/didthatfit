class SessionsController < ApplicationController
  def new
  end

  def instagram
    redirect_to(Instagram.authorize_url(:redirect_uri => callback_url))
  end

  def instagram_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => callback_url) # => a hash inside a hash {:access_token=> "",:user => {:id => "", :username => ""} }
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
      @current_user.instagram_id = nil
      @current_user.save
      redirect_to( edit_user_path( @current_user.username) )
    else
      session[:instagram_id] = response.user.id
      redirect_to( new_user_path )
    end
  end

  def create
    user = User.find_by(:username => params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id # session is a private hash rails uses
      redirect_to root_path
    else
      flash[:notice] = "Invalid login. Please try again"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:instagram_id] = nil

    redirect_to root_path
  end

  private
  def callback_url
    "http://" + request.host_with_port + "oauth/callback"
  end

end