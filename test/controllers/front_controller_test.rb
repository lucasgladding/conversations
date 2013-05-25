require 'test_helper'

class FrontControllerTest < ActionController::TestCase
  setup do
    @conversation = conversations(:one)
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conversation
    assert_response :success
  end

  test "should create conversation" do
    post :create, conversation: { topic: '' }, participant: 'admin'
    assert_redirected_to edit_front_path(assigns[:conversation])
  end

  test "should create message" do
    post :create_message, id: @conversation, message: { content: @message.content }
  end

  test "should update conversation" do
    post :update, id: @conversation, conversation: { topic: @conversation.topic }
    assert_redirected_to edit_front_path(@conversation)
  end

end
