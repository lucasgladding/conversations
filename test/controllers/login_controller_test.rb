require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    post :create, username: 'admin', password: 'password'
    assert_redirected_to root_url
  end

  test "should logout" do
    get :destroy
    assert_redirected_to login_url
  end

end
