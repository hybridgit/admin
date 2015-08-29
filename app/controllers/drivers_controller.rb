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
    @emergency_contacts = EmergencyContact.find_by_driver_id @driver.id
  end

  def new
    @driver = Driver.new
    @driver.build_address
    @car_types = CarType.all
    @operation_hours = OperationHour.all
    @contact_methods = ContactMethod.all
    @locations = Location.all
  end

  def edit
    @driver = Driver.find(params[:id])
    @car_types = CarType.all
    @operation_hours = OperationHour.all
    @contact_methods = ContactMethod.all
    @locations = Location.all
  end

  def create
    @driver = Driver.new(driver_params)

    respond_to do |format|
      if @driver.save
        format.html { redirect_to @driver, notice: 'Driver was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @driver = Driver.find(params[:id])
    @driver.update_attributes(driver_params)

    respond_to do |format|
      if @driver.update(driver_params)
        format.html { redirect_to @driver, notice: 'Driver was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver }
      else
        format.html { render :edit }
        format.json { render json: @driver.errors, status: :unprocessable_entity }
      end
    end
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

  private
  def driver_params
    params.require(:driver).permit(
      :id, :location_id, :address_id, :car_type_id, :contact_method_id, :operation_hour_id,
      :first_name, :last_name, :middle_name, :drivers_license_id, :date_of_birth,
      :profile_image, :drivers_license_copy, :is_active,
      address_attributes: [:id, :city, :sub_city, :woreda, :kebele, :house_number, :phone_number ]
    )
  end

end
