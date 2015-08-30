class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :driver_id
      t.integer :address_id
      t.integer :car_type_id
      t.integer :contact_method_id
      t.integer :operation_hour_id
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :drivers_license_id
      t.date :date_of_birth
      t.boolean :is_active
      t.attachment :profile_image
      t.attachment :drivers_license_copy

      t.timestamps null: false
    end
  end
end
