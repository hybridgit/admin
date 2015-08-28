class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name
      t.integer :relationship_id
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
