class ResetDriversTable < ActiveRecord::Migration
  def change
    change_table :drivers do |t|
      t.remove :location_id, :address_id, :car_type_id, :contact_method_id,
               :operation_hour_id, :first_name, :last_name, :middle_name,
               :drivers_license_id, :date_of_birth

      t.integer :profile_id
      t.string :name
      t.string :cell_no
      t.string :location
      t.string :location_lat
      t.string :location_long

    end
    remove_attachment :drivers, :profile_image
    remove_attachment :drivers, :drivers_license_copy
  end
end
