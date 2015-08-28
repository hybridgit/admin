class Address < ActiveRecord::Base
  attr_accessible :name
  has_one :driver, :dependent => :restrict_with_error
end
