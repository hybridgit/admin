class ProfilesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  def index
    @sort = params[:sort] ? params[:sort] : "updated_at"
    @direction = params[:direction] ? params[:direction] : "desc"

    case @sort
    when "is_active"
      @profiles = Profile.paginate(page: params[:page], per_page: 30).order("is_active #{@direction}")
    when "name"
      @profiles = Profile.paginate(page: params[:page], per_page: 30).order("first_name #{@direction}, middle_name #{@direction}, last_name #{@direction}")
    when "phone_number"
      @profiles = Profile.joins(:address).paginate(page: params[:page], per_page: 30).order("phone_number #{@direction}")
    when "location"
      @profiles = Profile.joins(:driver).paginate(page: params[:page], per_page: 30).order("location #{@direction}")
    when "trips"
      # TODO: sort by total trips
      @profiles = Profile.paginate(page: params[:page], per_page: 30).order("#{@sort} #{@direction}")
    else
      @profiles = Profile.paginate(page: params[:page], per_page: 30).order("#{@sort} #{@direction}")
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @emergency_contacts = EmergencyContact.find_by_profile_id @profile.id
  end

  def new
    @profile = Profile.new
    @profile.build_address
    @car_types = CarType.all
    @operation_hours = OperationHour.all
    @contact_methods = ContactMethod.all
    @drivers = Driver.all
  end

  def edit
    @profile = Profile.find(params[:id])
    @car_types = CarType.all
    @operation_hours = OperationHour.all
    @contact_methods = ContactMethod.all
    @drivers = Driver.all
  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes(profile_params)

    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @profile = Profile.find(params[:profile_id])
  end

  def destroy
    @profiles = Profile.paginate(page: params[:page], per_page: 30).order('updated_at DESC')
    @profile = Profile.find(params[:id])
    @error = nil

    begin
      @profile.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

  def activate
    @profile = Profile.find(params[:id])
    @profile.update_attributes({is_active: params[:is_active]})
    @response = {
      status: @profile.is_active? ,
      profile: @profile.display_field
    }

    respond_to do |format|
      format.json { render :json => @response }
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :id, :location_id, :address_id, :car_type_id, :contact_method_id, :operation_hour_id,
      :first_name, :last_name, :middle_name, :drivers_license_id, :date_of_birth,
      :profile_image, :drivers_license_copy, :is_active,
      address_attributes: [:id, :city, :sub_city, :woreda, :kebele, :house_number, :phone_number ]
    )
  end

end
