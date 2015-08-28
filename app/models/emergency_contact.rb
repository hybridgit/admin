class EmergencyContact < ActiveRecord::Base
  attr_accessible :name
  belongs_to :driver
  belongs_to :relationship
end
