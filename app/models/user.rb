class User < ActiveRecord::Base
  has_many :created_conversations, class_name: 'Conversation', foreign_key: 'creator_id'

  # use ConversationParticipant to create association between conversations and participants
  has_many :conversation_participants, foreign_key: 'participant_id'
  has_many :participated_conversations, class_name: 'Conversation', through: :conversation_participants, source: :participant

  has_secure_password

  validates :username, :email, presence: true, uniqueness: true

  before_create { generate_token(:auth_token) }

  def to_s
    username
  end

  private

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
