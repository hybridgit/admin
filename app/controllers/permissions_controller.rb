class PermissionsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  # GET /permissions
  # GET /permissions.xml
  def index
    @permissions = Permission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => PermissionsDatatable.new(view_context) }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    @permission = Permission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.xml
  def new
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.xml
  def create
    @permission = Permission.new(params[:permission])

    respond_to do |format|
      if @permission.save
        format.html { redirect_to(@permission, :notice => 'Permission was successfully created.') }
        format.xml { render :xml => @permission, :status => :created, :location => @permission }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to(@permission, :notice => 'Permission was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission = Permission.find(params[:id])
    @error = nil

    begin
      @permission.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end

    respond_to do |format|
      format.html { @error.nil? ? redirect_to(permissions_url) : redirect_to(@permission, :notice => @error) }
    end
  end
end
