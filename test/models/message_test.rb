require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "message attributes are required" do
    message = Message.new
    assert message.invalid?
    assert message.errors[:content].any?
  end

end
