class CreateCabRequests < ActiveRecord::Migration
  def change
    create_table :cab_requests do |t|
      t.string :location
      t.float :location_lat
      t.float :location_long
      t.string :current_cell_no
      t.references :driver_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
