require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  setup do
    @user = User.find_by_username('admin')
  end
  
  test "1. user can create an account on the system" do
    User.delete_all
    
    get '/register/new'
    assert_response :success
    
    post '/register', user: { username: 'aaa', email: 'aaa@example.com', password: 'password', password_confirmation: 'password' }
    assert_redirected_to '/'
    
    users = User.all
    user = users[0]
    assert_equal 1, users.count
    assert_equal 'aaa', user.username
    assert_equal 'aaa@example.com', user.email
  end
  
  test "2. user can log into account" do
    post '/login', username: 'admin', password: 'password'
    assert_redirected_to '/'
  end
  
  test "3. user can initiate a conversation" do
    Conversation.delete_all
    ConversationParticipant.delete_all
    
    get '/front/new'
    assert_response :success
    
    post '/front', conversation: { topic: 'Topic' }, participant: 'lucas'
    conversation = assigns[:conversation]
    assert_redirected_to edit_front_path(conversation)
    
    conversations = Conversation.all
    conversation = conversations[0]
    assert_equal 1, conversations.count
    assert_equal 'Topic', conversation.topic
  end
  
  test "4. creator can change topic" do
    conversation = conversations(:one)
    
    get edit_front_path(conversation)
    assert_response :success
    
    patch front_path(conversation), conversation: { topic: 'Updated Topic' }
    assert_redirected_to edit_front_path(conversation)
  end
  
  test "4. users can see conversations they are participating in" do
    conversation_participants = ConversationParticipant.where(participant: @user)
    
    get '/'
    assert_response :success
    
    li = css_select('#conversations li')
    assert_equal conversation_participants.count, li.count
    
    assert_select('#conversations li') do
      assert_select('.topic')
      assert_select('.participants')
    end
  end
  
  test "5. users can add a new message to conversations they are participating in" do
    conversation = conversations(:one)
    
    get edit_front_path(conversation)
    assert_response :success
    
    post create_message_front_path(conversation), message: { content: 'Lorem ipsum' }
    assert_redirected_to edit_front_path(conversation)
  end
  
  test "6. users can see an indicator when they have unread messages" do
    get '/'
    assert_response :success
    assert_select '#conversations' do
      assert_select '.unread-true'
      assert_select '.unread-false'
    end
  end
  
  test "7. users cannot access conversations they are not participating in" do
    conversation = conversations(:three)
    
    get edit_front_path(conversation)
    assert_redirected_to front_index_path
  end
end
