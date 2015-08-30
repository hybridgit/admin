class RemoveIsActiveFromDriver < ActiveRecord::Migration
  def change
    remove_column :drivers, :is_active, :boolean
  end
end
