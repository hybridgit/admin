class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :sub_city
      t.string :woreda
      t.string :kebele
      t.string :house_number

      t.timestamps null: false
    end
  end
end
