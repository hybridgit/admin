  class AddColumnToSendSms < ActiveRecord::Migration
  def change
    add_column :send_sms, :sql_id, :integer, :limit => 8
    add_column :send_sms, :udhdata, :binary
    add_column :send_sms, :time, :integer, :limit => 8
    add_column :send_sms, :service, :string
    add_column :send_sms, :account, :string
    add_column :send_sms, :mclass, :integer, :limit => 8
    add_column :send_sms, :mwi, :integer, :limit => 8
    add_column :send_sms, :coding, :integer, :limit => 8
    add_column :send_sms, :compress, :integer, :limit => 8
    add_column :send_sms, :validity, :integer, :limit => 8
    add_column :send_sms, :deferred, :integer, :limit => 8
    add_column :send_sms, :dlr_mask, :integer, :limit => 8
    add_column :send_sms, :dlr_url, :string
    add_column :send_sms, :pid, :integer, :limit => 8
    add_column :send_sms, :alt_dcs, :integer, :limit => 8
    add_column :send_sms, :rpi, :integer, :limit => 8
    add_column :send_sms, :charset, :string
    add_column :send_sms, :boxc_id, :string
    add_column :send_sms, :binfo, :string
    add_column :send_sms, :meta_data, :text
    add_column :send_sms, :foreign_id, :string
  end
end
