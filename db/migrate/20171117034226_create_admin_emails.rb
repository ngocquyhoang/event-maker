class CreateAdminEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_emails do |t|
      t.text :to_email
      t.text :subject
      t.text :email_body
      t.timestamps
    end
  end
end
