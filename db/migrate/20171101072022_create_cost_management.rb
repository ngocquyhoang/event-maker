class CreateCostManagement < ActiveRecord::Migration[5.1]
  def change
    create_table :cost_managements do |t|
      t.integer :type, null: false
      t.integer :amount, null: false
      t.string :note
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
