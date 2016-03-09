class AuthenticateController < ApplicationController
  def dashboard
    if session[:user_type] == "Teacher"
      redirect_to teachers_dashboard_path
    elsif session[:user_type] == "Student"
      redirect_to students_dashboard_path
    elsif session[:user_type] == "Parent"
      redirect_to parents_dashboard_path
    else
      redirect_to authenticate_login_path
    end
  end

  def login
    if request.post?
      user = params[:user]
      u = user.constantize.find_by(email: params[:email])
      if u && u.authenticate(params[:password])
        session[:user_id] = u.id
        session[:user_type] = user
        redirect_to root_path, notice: "Login successful"
      else
        flash.now[:notice] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to authenticate_login_path, notice: "Logout succesful"
  end
end
