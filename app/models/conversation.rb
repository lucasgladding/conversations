class Conversation < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  # use ConversationParticipant to create association between conversations and participants
  has_many :conversation_participants, dependent: :destroy
  has_many :participants, class_name: 'User', through: :conversation_participants

  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy

  accepts_nested_attributes_for :conversation_participants,
    allow_destroy: true,
    reject_if:     proc { |attributes| attributes[:participant_id].blank? }

  accepts_nested_attributes_for :messages,
    allow_destroy: true,
    reject_if:     proc { |attributes| attributes[:content].blank? }

  def to_s
    if topic.blank?
      return 'untitled'
    else
      return topic
    end
  end

  def participants_usernames
    usernames = []
    participants.each do |participant|
      usernames << participant.username
    end
    usernames.join(', ')
  end

  def get_conversation_participant(user)
    conversation_participants.each do |conversation_participant|
      if conversation_participant.participant == user
        return conversation_participant
      end
    end
    return false
  end

  def append_participant(user)
    unless has_participant?(user)
      conversation_participants << ConversationParticipant.new(participant: user, has_unread_messages: true)
    end
  end

  def has_participant?(user)
    get_conversation_participant(user) != false
  end

  def mark_unread(value)
    conversation_participants.each do |conversation_participant|
      conversation_participant.has_unread_messages = true
      conversation_participant.save
    end
  end

  def mark_unread_for_user(user, value)
    conversation_participant = get_conversation_participant(user)
    if conversation_participant
      conversation_participant.has_unread_messages = value
      conversation_participant.save
    end
  end

end
