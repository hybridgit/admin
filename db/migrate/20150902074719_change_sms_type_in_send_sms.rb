class ChangeSmsTypeInSendSms < ActiveRecord::Migration
  def change
    change_table :send_sms do |t|
      t.change :sms_type, :integer, :limit => 8
    end
  end
end
