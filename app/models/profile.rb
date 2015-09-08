class Profile < ActiveRecord::Base
  attr_accessible :id, :driver_id, :address_id, :car_type_id, :contact_method_id, :operation_hour_id,
                  :first_name, :last_name, :middle_name, :drivers_license_id, :date_of_birth,
                  :profile_image, :drivers_license_copy, :is_active, :address_attributes

  has_one :address, :dependent => :destroy
  has_one :driver, :dependent => :restrict_with_error

  has_many :emergency_contacts, :dependent => :destroy

  belongs_to :car_type
  belongs_to :contact_method
  belongs_to :operation_hour

  has_attached_file :profile_image, styles: { medium: "300x360>", thumb: "150x180>" }, default_url: "/images/:style/profile_placeholder.png"
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\Z/

  has_attached_file :drivers_license_copy, styles: { medium: "300x200>", thumb: "150x100>" }, default_url: "/images/:style/id_placeholder.png"
  validates_attachment_content_type :drivers_license_copy, content_type: /\Aimage\/.*\Z/

  accepts_nested_attributes_for :address

  def display_field
    return "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

  def phone_number
    return self.address ? self.address.phone_number : "N/A"
  end

  def location_name
    return self.driver ? self.driver.location : "N/A"
  end

  def car_type_name
    return self.car_type ? self.car_type.name : "N/A"
  end

  def operation_hour_name
    return self.operation_hour ? self.operation_hour.name : "N/A"
  end

  def contact_method_name
    return self.contact_method ? self.contact_method.name : "N/A"
  end
end
