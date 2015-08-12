class RolePermissionsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  # GET /role_permissions
  # GET /role_permissions.xml
  def index
    @role = Role.find(params[:role_id])
    @role_permissions = @role.role_permissions.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => RolePermissionsDatatable.new(view_context), :parent => @role }
    end
  end

  # GET /role_permissions/1
  # GET /role_permissions/1.xml
  def show
    @role_permission = RolePermission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @role_permission }
    end
  end

  # GET /role_permissions/new
  # GET /role_permissions/new.xml
  def new
    @role = Role.find(params[:role_id])
    @role_permission = RolePermission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @role_permission }
    end
  end

  # GET /role_permissions/1/edit
  def edit
    @role_permission = RolePermission.find(params[:id])
  end

  # POST /role_permissions
  # POST /role_permissions.xml
  def create
    @role = Role.find(params[:role_id])
    @role_permissions = params[:role_permissions]
    @role_permissions.each do |role_permission|
      @attrs = role_permission.split("-")
      if !@role.has_permission?(@attrs[0], @attrs[1])
        @permission = Permission.create!({:controller => @attrs[0], :action => @attrs[1]})
        @role_permission = @role.role_permissions.build({:role_id => @role.id, :permission_id => @permission.id})
        if !@role_permission.save
          respond_to do |format|
            format.html { render :action => "new" }
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to(role_permissions_path, :notice => 'Role permission was successfully created.') }
    end
  end

  # PUT /role_permissions/1
  # PUT /role_permissions/1.xml
  def update
    @role_permission = RolePermission.find(params[:id])

    respond_to do |format|
      if @role_permission.update_attributes(params[:role_permission])
        format.html { redirect_to(@role_permission, :notice => 'Role permission was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @role_permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /role_permissions/1
  # DELETE /role_permissions/1.xml
  def destroy
    @role_permission = RolePermission.find(params[:id])
    @role_permission.destroy

    respond_to do |format|
      format.html { redirect_to(role_permissions_url) }
      format.xml { head :ok }
    end
  end
end
