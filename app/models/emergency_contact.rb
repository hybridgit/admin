class EmergencyContact < ActiveRecord::Base
  attr_accessible :name, :driver_id, :relationship_id, :phone_number
  belongs_to :driver
  belongs_to :relationship
end
