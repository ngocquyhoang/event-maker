class CreatePayment < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.text :notification_params
      t.integer :user_id
      t.string :description
      t.string :status
      t.string :transaction_id
      t.string :amount
      t.integer :payment_type
      t.datetime :purchased_at


      t.timestamp
    end
  end
end
