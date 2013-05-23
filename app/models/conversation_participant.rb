class ConversationParticipant < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :participant, class_name: 'User'
end
