class UserRolesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @user_role = UserRole.new
    @user_role_ids = @user.user_roles.map {|user_role| user_role.role_id}
    @available_roles = @user_role_ids.empty? ?  Role.all : Role.where("id NOT IN (?)", @user_role_ids)
  end

  def create
    @user = User.find(params[:user_id])
    @user_role = UserRole.create(params[:user_role])
  end

  def delete
    @user = User.find(params[:user_id])
    @user_role = UserRole.find(params[:role_id])
  end

  def destroy
    @user_role = UserRole.find(params[:id])
    @user_role.destroy
    @user = User.find(params[:user_id])
  end
end
