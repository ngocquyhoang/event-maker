class CreateLayout < ActiveRecord::Migration[5.1]
  def change
    create_table :layouts do |t|
      t.string :title
      t.text :html
      t.datetime :start_time
      t.datetime :end_time
      t.text :main_description
      t.text :sub_description
      t.string :address
      t.integer :event_type_id

      t.timestamps
    end
  end
end
