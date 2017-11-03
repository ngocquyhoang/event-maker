class CreateEvent < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :slug, unique: true
      t.integer :user_id
      t.integer :layout_id
      t.datetime :start_time
      t.datetime :end_time
      t.text :main_description
      t.text :sub_description
      t.integer :event_type_id
      t.string :address
      t.string :scale
      t.integer :est_amount_people
      t.integer  :expense
      t.string :title_layout
      t.string :seo_keyword
      t.boolean :use_form
      t.string :google_form_url

      t.timestamps
    end
  end
end
