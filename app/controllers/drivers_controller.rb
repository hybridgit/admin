class DriversController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  def index
    @drivers = Driver.paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def new
    @driver = Driver.new
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def create
    @drivers = Driver.paginate(page: params[:page], per_page: 30).order('created_at DESC')
    @driver = Driver.create(params[:driver])
  end

  def update
    @driver = Driver.find(params[:id])
    @driver.update_attributes(params[:driver])
    @drivers = Driver.paginate(page: params[:page], per_page: 30).order('created_at DESC')
  end

  def delete
    @driver = Driver.find(params[:driver_id])
  end

  def destroy
    @drivers = Driver.paginate(page: params[:page], per_page: 30).order('created_at DESC')
    @driver = Driver.find(params[:id])
    @error = nil

    begin
      @driver.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
