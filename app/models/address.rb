class Address < ActiveRecord::Base
  attr_accessible :id, :profile_id, :city, :sub_city, :woreda, :kebele, :house_number, :phone_number
  belongs_to :profile
end
