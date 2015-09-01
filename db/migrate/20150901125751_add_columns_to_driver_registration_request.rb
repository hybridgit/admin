class AddColumnsToDriverRegistrationRequest < ActiveRecord::Migration
  def change
    add_column :driver_registration_requests, :more_location_count, :integer
    add_column :driver_registration_requests, :searched_location, :string
    add_column :driver_registration_requests, :deleted, :boolean
  end
end
