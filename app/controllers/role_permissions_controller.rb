class RolePermissionsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  def index
    @role = Role.find(params[:role_id])
  end

  def new
    @role = Role.find(params[:role_id])
    @role_permission = RolePermission.new
    @role_permission_ids = @role.role_permissions.map {|role_permission| role_permission.permission_id}
    @available_permissions = @role_permission_ids.empty? ? Permission.all : Permission.where("id NOT IN (?)", @role_permission_ids)
  end

  def create
    @role = Role.find(params[:role_id])
    @role_permission = RolePermission.create(params[:role_permission])
  end

  def delete
    @role = Role.find(params[:role_id])
    @role_permission = RolePermission.find(params[:permission_id])
  end

  def destroy
    @role_permission = RolePermission.find(params[:id])
    @role_permission.destroy
    @role = Role.find(params[:role_id])
  end
end
