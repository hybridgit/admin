class ContactMethodsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /contact_methods
  # GET /contact_methods.js

  def index
    @contact_methods = ContactMethod.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /contact_methods/1
  # GET /contact_methods/1.js
  def show
    @contact_method = ContactMethod.find(params[:id])
  end

  # GET /contact_methods/new
  def new
    @contact_method = ContactMethod.new
  end

  # GET /contact_methods/1/edit
  def edit
    @contact_method = ContactMethod.find(params[:id])
  end

  # POST /contact_methods
  # POST /contact_methods.js

  def create
    @contact_methods = ContactMethod.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @contact_method = ContactMethod.create(params[:contact_method])
  end

  # PATCH/PUT /contact_methods/1
  # PATCH/PUT /contact_methods/1.json
  def update
    @contact_method = ContactMethod.find(params[:id])
    @contact_method.update_attributes(params[:contact_method])
    @contact_methods = ContactMethod.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /contact_method/1/delete
  # GET /contact_method/1/delete.js
  def delete
    @contact_method = ContactMethod.find(params[:contact_method_id])
  end

  # DELETE /contact_methods/1
  # DELETE /contact_methods/1.json
  def destroy
    @contact_methods = ContactMethod.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @contact_method = ContactMethod.find(params[:id])
    @error = nil

    begin
      @contact_method.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
