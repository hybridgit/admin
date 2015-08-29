class CarTypesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /car_types
  # GET /car_types.js
  def index
    @car_types = CarType.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /car_types/1
  # GET /car_types/1.js
  def show
    @car_type = CarType.find(params[:id])
  end

  # GET /car_types/new
  def new
    @car_type = CarType.new
  end

  # GET /car_types/1/edit
  def edit
    @car_type = CarType.find(params[:id])
  end

  # POST /car_types
  # POST /car_types.js

  def create
    @car_types = CarType.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @car_type = CarType.create(params[:car_type])
  end

  # PATCH/PUT /car_types/1
  # PATCH/PUT /car_types/1.json
  def update
    @car_type = CarType.find(params[:id])
    @car_type.update_attributes(params[:car_type])
    @car_types = CarType.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /car_type/1/delete
  # GET /car_type/1/delete.js
  def delete
    @car_type = CarType.find(params[:car_type_id])
  end

  # DELETE /car_types/1
  # DELETE /car_types/1.json
  def destroy
    @car_types = CarType.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')
    @car_type = CarType.find(params[:id])
    @error = nil

    begin
      @car_type.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
