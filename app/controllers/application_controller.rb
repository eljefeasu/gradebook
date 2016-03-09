class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private def authenticate
    redirect_to authenticate_login_path, notice: "You must be logged in to access this page." unless session[:user_id]
  end
end
