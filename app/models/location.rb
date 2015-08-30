class Location < ActiveRecord::Base
  attr_accessible :location_name, :latitude, :longitude
end
