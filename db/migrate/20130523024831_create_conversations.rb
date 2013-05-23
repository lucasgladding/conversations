class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :topic
      t.references :creator, index: true

      t.timestamps
    end
  end
end
