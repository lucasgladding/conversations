class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.text :content

      t.timestamps
    end
  end
end
