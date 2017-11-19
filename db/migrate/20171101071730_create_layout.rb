class CreateLayout < ActiveRecord::Migration[5.1]
  def change
    create_table :layouts do |t|
      t.string :name
      t.string :featured_image
      t.text :html
      t.text :css
      t.text :javascript
      t.text :event_types

      t.timestamps
    end
  end
end
