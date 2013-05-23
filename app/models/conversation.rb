class Conversation < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  # use ConversationParticipant to create association between conversations and participants
  has_many :conversation_participants
  has_many :participants, class_name: 'User', through: :conversation_participants

  has_many :messages

  MAX_PARTICIPANTS = 2

  accepts_nested_attributes_for :conversation_participants,
    allow_destroy: true,
    reject_if:     proc { |attributes| attributes[:participant_id].blank? }

  accepts_nested_attributes_for :messages,
    allow_destroy: true,
    reject_if:     proc { |attributes| attributes[:content].blank? }

  def to_s
    topic
  end

  def participant_usernames
    usernames = []
    participants.each do |participant|
      usernames << participant.username
    end
    usernames.join(', ')
  end

end
