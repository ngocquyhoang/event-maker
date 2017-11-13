class ChangeCostTypeName < ActiveRecord::Migration[5.1]
  def change
    rename_column :cost_managements, :type, :cost_type
  end
end
