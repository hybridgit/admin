class CarType < ActiveRecord::Base
  attr_accessible :name
  has_many :profiles, :dependent => :restrict_with_error
end
