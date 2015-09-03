class LocationsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  require 'roo'
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /locations/1
  # GET /locations/1.js
  def show
    @location = Location.find(params[:id])
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.js
  def create
    @locations = Location.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @location = Location.create(params[:location])
  end

  # GET /locations/import
  def import
    @location = Location.new
  end

  # POST /locations/upload
  def upload
    if params[:file].present?
      file = Roo::Excelx.new(params[:file].path,nil, :ignore)
      (file.first_row+1..file.last_row).each do |i|
        row = file.row(i)
        check_location = Location.where(:location_name => row[0]).first
        if check_location.present?
          check_location.update_attributes(:location_name => row[0], :latitude => row[1], :longitude => row[2])
        else
          Location.create(:location_name => row[0], :latitude => row[1], :longitude => row[2])
        end
      end
      redirect_to locations_path
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.js
  def update
    @location = Location.find(params[:id])
    @location.update_attributes(params[:location])
    @locations = Location.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /user/1/delete
  # GET /user/1/delete.js
  def delete
    @location = Location.find(params[:location_id])
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @locations = Location.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @location = Location.find(params[:id])
    begin
      @location.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
