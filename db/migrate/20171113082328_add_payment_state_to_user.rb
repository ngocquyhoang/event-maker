class AddPaymentStateToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :acc_state, :integer
    add_column :users, :https_use_count, :integer
  end
end
