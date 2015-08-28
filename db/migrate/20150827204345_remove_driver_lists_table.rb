class RemoveDriverListsTable < ActiveRecord::Migration
  def up
    drop_table :driver_lists
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
