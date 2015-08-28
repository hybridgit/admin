class ContactMethod < ActiveRecord::Base
  attr_accessible :name
  has_many :drivers, :dependent => :restrict_with_error
end
