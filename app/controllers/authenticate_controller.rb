class AuthenticateController < ApplicationController
  def dashboard
    if session[:teacher_id]
      redirect_to teachers_dashboard_path
    else
      redirect_to authenticate_login_path
    end
  end

  def login
    if request.post?
      t = Teacher.find_by(email: params[:email])
      if t && t.authenticate(params[:password])
        session[:teacher_id] = t.id
        redirect_to teachers_dashboard_path, notice: "Login successful"
      else
        flash[:notice] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:teacher_id] = nil
    redirect_to authenticate_login_path, notice: "Logout succesful"
  end
end
