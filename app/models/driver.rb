class Driver < ActiveRecord::Base
  attr_accessible *column_names

  has_one :address, :dependent => :destroy
  has_many :emergency_contacts, :dependent => :destroy
  belongs_to :car_type
  belongs_to :contact_method
  belongs_to :operation_hour

  def display_field
    return "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end
end
