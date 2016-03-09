require 'test_helper'

class AuthenticateControllerTest < ActionController::TestCase
  setup do
    @teacher = teachers(:one)
    session[:user_id] = @teacher.id
    session[:user_type] = "Teacher"
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :found
  end

end
