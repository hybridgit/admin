class Relationship < ActiveRecord::Base
  attr_accessible :name
  has_many :emergency_contacts, :dependent => :restrict_with_error
end
