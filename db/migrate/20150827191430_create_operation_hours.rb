class CreateOperationHours < ActiveRecord::Migration
  def change
    create_table :operation_hours do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
