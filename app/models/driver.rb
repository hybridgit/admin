class Driver < ActiveRecord::Base
  attr_accessible :name, :location, :location_lat, :locaiton_long
end
