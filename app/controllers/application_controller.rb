class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user # does the method named this before any other action

  private

  def authenticate_user
    if session[:user_id].present? #instead of comparing .nil? and == "". only for rails
      @current_user = User.where(:id => session[:user_id]).first # .find throws fatal error if nothing, .where will return nil if nothing else returns array
    end

    if @current_user.nil?
      session[:user_id] = nil
    end
  end

  def check_if_logged_in
    redirect_to(root_path) if @current_user.nil?
  end

  def check_if_admin
    redirect_to(root_path) unless @current_user.is_admin?
  end

  ForecastIO.configure do |configuration|
    configuration.api_key = 'eded896de561f7d609f6e31f5d4d381b'
  end

  # CALLBACK_URL = "http://localhost:3000/oauth/callback"
  CALLBACK_URL = "http://didthatfit.herokuapp.com/oauth/callback"

  Instagram.configure do |config|
    config.client_id = "443fb627019a405f920e934c9c068ec4"
    config.client_secret = "771185a71c734b319e85a835c172b817"
  end

end