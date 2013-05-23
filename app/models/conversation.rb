class Conversation < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :conversation_participants
  has_many :participants, through: :conversation_participants

  def to_s
    topic
  end
end
