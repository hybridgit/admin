class RemoveDriverListIdFromCabRequest < ActiveRecord::Migration
  def change
    remove_column :cab_requests, :driver_list_id, :integer
  end
end
