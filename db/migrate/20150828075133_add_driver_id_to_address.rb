class AddDriverIdToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :driver_id, :integer
  end
end
