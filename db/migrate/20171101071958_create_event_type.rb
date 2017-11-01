class CreateEventType < ActiveRecord::Migration[5.1]
  def change
    create_table :event_types do |t|
      t.string :label, null: false
    end
  end
end
