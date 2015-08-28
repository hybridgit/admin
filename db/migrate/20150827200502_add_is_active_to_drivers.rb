class AddIsActiveToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :is_active, :boolean
  end
end
