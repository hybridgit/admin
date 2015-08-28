class Location < ActiveRecord::Base
  attr_accessible :location_name, :latitude, :longitude

  has_many :drivers, :dependent => :restrict_with_error
end
