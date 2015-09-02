class RemoveMomtFromSendSms < ActiveRecord::Migration
  def change
    remove_column :send_sms, :momt
  end
end
