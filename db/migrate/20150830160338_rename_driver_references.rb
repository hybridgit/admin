class RenameDriverReferences < ActiveRecord::Migration
  def change
    rename_column :addresses, :driver_id, :profile_id
    rename_column :emergency_contacts, :driver_id, :profile_id
  end
end
