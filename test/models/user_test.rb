require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user attributes are required" do
    user = User.new
    assert user.invalid?
    assert user.errors[:username].any?
    assert user.errors[:email].any?
  end

  test "user username is unique" do
    user_attributes = { username: 'aaa', email: 'aaa@example.com', password: 'password', password_confirmation: 'password' }
    User.create(user_attributes)
    user = User.new(user_attributes)
    assert !user.save
    assert_equal 'has already been taken', user.errors[:username].join('; ')
    assert_equal 'has already been taken', user.errors[:email].join('; ')
  end

end
