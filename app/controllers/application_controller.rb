class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private def authenticate
    redirect_to authenticate_login_path, notice: "You must be logged in to access this page." unless session[:user_id]
  end

  private def authenticate_teacher
    begin
      redirect_to :back, notice: "You do not have permission to access that page." unless session[:user_type] == "Teacher"
    rescue ActionController::RedirectBackError
      redirect_to root_path, notice: "You do not have permission to access that page." unless session[:user_type] == "Teacher"
    end
  end
end
