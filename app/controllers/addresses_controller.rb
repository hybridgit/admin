class AddressesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /addresses
  # GET /addresses.js

  def index
    @addresses = Address.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /addresses/1
  # GET /addresses/1.js
  def show
    @address = Address.find(params[:id])
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.js

  def create
    @addresses = Address.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @address = Address.create(params[:address])
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    @address = Address.find(params[:id])
    @address.update_attributes(params[:address])
    @addresses = Address.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /address/1/delete
  # GET /address/1/delete.js
  def delete
    @address = Address.find(params[:address_id])
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @addresses = Address.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')
    @address = Address.find(params[:id])
    @error = nil

    begin
      @address.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
