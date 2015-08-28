class OperationHoursController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /operation_hours
  # GET /operation_hours.js

  def index
    @operation_hours = OperationHour.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  # GET /operation_hours/1
  # GET /operation_hours/1.js
  def show
    @operation_hour = OperationHour.find(params[:id])
  end

  # GET /operation_hours/new
  def new
    @operation_hour = OperationHour.new
  end

  # GET /operation_hours/1/edit
  def edit
    @operation_hour = OperationHour.find(params[:id])
  end

  # POST /operation_hours
  # POST /operation_hours.js

  def create
    @operation_hours = OperationHour.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @operation_hour = OperationHour.create(params[:operation_hour])
  end

  # PATCH/PUT /operation_hours/1
  # PATCH/PUT /operation_hours/1.json
  def update
    @operation_hour = OperationHour.find(params[:id])
    @operation_hour.update_attributes(params[:operation_hour])
    @operation_hours = OperationHour.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  # GET /operation_hour/1/delete
  # GET /operation_hour/1/delete.js
  def delete
    @operation_hour = OperationHour.find(params[:operation_hour_id])
  end

  # DELETE /operation_hours/1
  # DELETE /operation_hours/1.json
  def destroy
    @operation_hours = OperationHour.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
    @operation_hour = OperationHour.find(params[:id])
    @error = nil

    begin
      @operation_hour.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end
end
