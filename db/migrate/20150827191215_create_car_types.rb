class CreateCarTypes < ActiveRecord::Migration
  def change
    create_table :car_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end