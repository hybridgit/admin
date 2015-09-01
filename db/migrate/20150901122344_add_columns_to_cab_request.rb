class AddColumnsToCabRequest < ActiveRecord::Migration
  def change
    add_column :cab_requests, :current_driver_id, :integer
    add_column :cab_requests, :customer_cell_no, :string
    add_column :cab_requests, :broadcast, :boolean
    add_column :cab_requests, :status, :boolean
    add_column :cab_requests, :chosen_drivers_ids, :string
    add_column :cab_requests, :more_locations, :text
    add_column :cab_requests, :ordered, :boolean
    add_column :cab_requests, :location_selected, :boolean
    add_column :cab_requests, :offer_count, :integer
    add_column :cab_requests, :broadcasted, :boolean
    add_column :cab_requests, :deleted, :boolean
    add_column :cab_requests, :final_driver_id, :integer
    add_column :cab_requests, :closed, :boolean
    add_column :cab_requests, :more_location_count, :integer
  end
end
