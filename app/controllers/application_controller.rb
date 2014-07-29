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
    configuration.api_key = ENV['FORECAST_API']
  end

  # CALLBACK_URL = "http://" + request.host_with_port + "oauth/callback" # if Rails.env.development?
  # CALLBACK_URL = "http://didthatfit.herokuapp.com/oauth/callback" if Rails.env.production?

  Instagram.configure do |config|
    config.client_id = ENV['INSTAGRAM_CLIENT_ID']
    config.client_secret = ENV['INSTAGRAM_SECRET']
  end

end