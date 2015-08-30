class EmergencyContact < ActiveRecord::Base
  attr_accessible :name, :profile_id, :relationship_id, :phone_number
  belongs_to :profile
  belongs_to :relationship
end
