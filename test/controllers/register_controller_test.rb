require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    post :create, user: { email: 'aaa@example.com', password: 'password', password_confirmation: 'password', username: 'aaa' }
    assert_redirected_to root_url
  end

  test "should get edit" do
    # get :edit
    # assert_response :success
  end

  test "should update user" do
    # get :update
    # assert_response :success
  end

end
