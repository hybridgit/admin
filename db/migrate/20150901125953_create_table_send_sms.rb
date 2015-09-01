class CreateTableSendSms < ActiveRecord::Migration
  def change
    create_table :send_sms do |t|
      t.string :momt
      t.string :sender
      t.string :receiver
      t.text :msgdata
      t.integer :sms_type
      t.string :smsc_id
    end
  end
end
