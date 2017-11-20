class CreateBaokim < ActiveRecord::Migration[5.1]
  def change
    create_table :baokims do |t|
      t.text :notification_params
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at
    end
  end
end
