class AddMomtToSendSms < ActiveRecord::Migration
  def change
    add_column :send_sms, :momt, "ENUM('MO','MT')"
  end
end
