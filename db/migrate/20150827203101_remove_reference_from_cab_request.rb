class RemoveReferenceFromCabRequest < ActiveRecord::Migration
  def change
    remove_foreign_key :cab_requests, :driver_lists
  end
end
