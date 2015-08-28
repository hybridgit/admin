class EmergencyContactsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /emergency_contacts
  # GET /emergency_contacts.js

  def index
    @driver = Driver.find(params[:driver_id])
  end

  # GET /emergency_contacts/new
  def new
    @driver = Driver.find(params[:driver_id])
    @emergency_contact = EmergencyContact.new
    @relationships = Relationship.all
  end

  # POST /emergency_contacts
  # POST /emergency_contacts.js

  def create
    @driver = Driver.find(params[:driver_id])
    @emergency_contact = EmergencyContact.create(params[:emergency_contact])
  end

  # GET /emergency_contact/1/delete
  # GET /emergency_contact/1/delete.js
  def delete
    @driver = Driver.find(params[:driver_id])
    @emergency_contact = EmergencyContact.find(params[:contact_id])
  end

  # DELETE /emergency_contacts/1
  # DELETE /emergency_contacts/1.json
  def destroy
    @emergency_contact = EmergencyContact.find(params[:id])
    @driver = Driver.find(params[:driver_id])
    @error = nil

    begin
      @emergency_contact.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
