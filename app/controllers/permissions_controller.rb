class PermissionsController < ApplicationController

  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /permissions
  # GET /permissions.js
  def index
    @permissions = Permission.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  # GET /permissions/1
  # GET /permissions/1.js
  def show
    @permission = Permission.find(params[:id])
  end

  # GET /permissions/new
  # GET /permissions/new.js
  def new
    @permission = Permission.new
    @available_controllers = Permission.controllers
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
    @available_controllers = Permission.controllers
  end

  # POST /permissions
  # POST /permissions.js
  def create
    @permissions = Permission.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @permission = Permission.create(params[:permission])
  end

  # PUT /permissions/1
  # PUT /permissions/1.js
  def update
    @permission = Permission.find(params[:id])
    @permission.update_attributes(params[:permission])
    @permissions = Permission.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  # GET /permission/1/delete
  # GET /permission/1/delete.js
  def delete
    @permission = Permission.find(params[:permission_id])
  end

  # GET /permission/actions?controller=controllerName
  # GET /permission/actions.js?controller=controllerName
  def actions
    @actions = Permission.actions(params[:permissions_controller])

    respond_to do |format|
      format.json { render :json => @actions }
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.js
  def destroy
    @permissions = Permission.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @permission = Permission.find(params[:id])
    @error = nil

    begin
      @permission.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end
end
