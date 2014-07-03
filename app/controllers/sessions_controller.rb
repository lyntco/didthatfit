class SessionsController < ApplicationController
  def new
  end

  # def fb_create
  #   user = User.from_omniauth(env["omniauth.auth"])
  #   session[:user_id] = user.id # session is a private hash rails uses
  #   redirect_to root_path
  # end

  def instagram
    redirect_to(Instagram.authorize_url(:redirect_uri => CALLBACK_URL))
  end

  def instagram_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL) # => a hash inside a hash {:access_token=> "",:user => {} }
    #<Hashie::Mash access_token="5538991.443fb62.c9e5031ee5f74d56851270e7371420b8" user=#<Hashie::Mash bio="" full_name="Strawdoll" id="5538991" profile_picture="http://images.ak.instagram.com/profiles/profile_5538991_75sq_1376843347.jpg" username="strawz" website="http://facebook.com/strawdoll">>
    session[:access_token] = response.access_token

    # raise params.inspect
    already_signed_up = User.find_by(:instagram_id => response.user.id)
    if already_signed_up
      # already_signed_up.id = response.user.id
      # already_signed_up.save
      session[:user_id] = already_signed_up.id
    end
    redirect_to(root_path)
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