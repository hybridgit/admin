class CreateSentSms < ActiveRecord::Migration
  def change
    create_table :sent_sms do |t|
      t.integer :sql_id, :limit => 8
      t.column :momt, "ENUM('MO','MT')"
      t.string :sender
      t.string :receiver
      t.binary :udhdata
      t.text :msgdata
      t.integer :time, :limit => 8
      t.string :smsc_id
      t.string :service
      t.string :account
      t.integer :sms_type, :limit => 8
      t.integer :mclass, :limit => 8
      t.integer :mwi, :limit => 8
      t.integer :coding, :limit => 8
      t.integer :compress, :limit => 8
      t.integer :validity, :limit => 8
      t.integer :deferred, :limit => 8
      t.integer :dlr_mask, :limit => 8
      t.string :dlr_url
      t.integer :pid, :limit => 8
      t.integer :alt_dcs, :limit => 8
      t.integer :rpi, :limit => 8
      t.string :charset
      t.string :boxc_id
      t.string :binfo
      t.text :meta_data
      t.string :foreign_id
    end
  end
end
