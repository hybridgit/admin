class EditDrivers < ActiveRecord::Migration
  def change
    change_table :drivers do |t|
      t.remove :name, :location, :location_lat, :location_long
      t.integer :location_id
      t.integer :address_id
      t.integer :car_type_id
      t.integer :contact_method_id
      t.integer :operation_hour_id
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :drivers_license_id
      t.date :date_of_birth
      t.attachment :profile_image
      t.attachment :drivers_license_copy
    end
  end
end
