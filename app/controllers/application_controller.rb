class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private def authenticate
    if session[:teacher_id].nil?
      redirect_to authenticate_login_path, notice: "Must be logged in to view that page"
    end
  end
end
