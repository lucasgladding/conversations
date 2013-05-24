class AddReadToConversationParticipants < ActiveRecord::Migration
  def change
    add_column :conversation_participants, :has_unread_messages, :boolean
  end
end
