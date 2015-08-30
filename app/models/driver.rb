class Driver < ActiveRecord::Base
  attr_accessible :profile_id, :name, :cell_no, :location, :location_lat, :location_long
end
