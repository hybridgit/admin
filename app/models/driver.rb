class Driver < ActiveRecord::Base
  attr_accessible :profile_id, :name, :cell_no, :location, :location_lat, :location_long
  acts_as_mappable :lat_column_name => :location_lat,
                   :lng_column_name => :location_long
  reverse_geocoded_by :location_lat, :location_long

  has_many :cab_requests
 	has_many :driver_lists

  def self.is_not_driver(cell_no)
    @driver=Driver.where(:cell_no=>cell_no).last
    if @driver.present?
      return false
    else
      return true
    end
  end
end
