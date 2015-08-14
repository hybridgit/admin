class RolesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html,:js

  # GET /roles
  # GET /roles.js
  def index
    @roles = Role.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end

  # GET /roles/1
  # GET /roles/1.js
  def show
    @role = Role.find(params[:id])
  end

  # GET /roles/new
  # GET /roles/new.js
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.js
  def create
    @roles = Role.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @role = Role.create(params[:role])
  end

  # PUT /roles/1
  # PUT /roles/1.js
  def update
    @role = Role.find(params[:id])
    @role.update_attributes(params[:role])
    @roles = Role.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end

  # GET /user/1/delete
  # GET /user/1/delete.js
  def delete
    @role = Role.find(params[:role_id])
  end

  # DELETE /roles/1
  # DELETE /roles/1.js
  def destroy
    @roles = Role.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @role = Role.find(params[:id])
    @error = nil
    unless @role.name == "Administrator"
      begin
        @role.destroy
      rescue ActiveRecord::DeleteRestrictionError => e
        @error = e.message
      end
    else
      @error = "You cannot delete Administrator role!"
    end
  end

end
