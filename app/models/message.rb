class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  def to_s
    content
  end

end
