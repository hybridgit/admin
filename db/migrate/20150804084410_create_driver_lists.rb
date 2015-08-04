class CreateDriverLists < ActiveRecord::Migration
  def change
    create_table :driver_lists do |t|
      t.string :name
      t.float :location_lat
      t.float :location_long
      t.string :location

      t.timestamps null: false
    end
  end
end
