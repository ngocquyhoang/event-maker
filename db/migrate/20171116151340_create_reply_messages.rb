class CreateReplyMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :reply_messages do |t|
      t.integer :message_id
      t.text :content
      
      t.timestamps
    end
  end
end
