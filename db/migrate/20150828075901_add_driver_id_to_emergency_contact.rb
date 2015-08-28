class AddDriverIdToEmergencyContact < ActiveRecord::Migration
  def change
    add_column :emergency_contacts, :driver_id, :integer
  end
end
