class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :except => [:new, :create, :show] do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /users
  # GET /users.js
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end

  # GET /users/1
  # GET /users/1.js
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.js
  def new
    @user = User.new
  end

  # GET /users/1/edit
  # GET /users/1/edit.js
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.js
  def create
    @users = User.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @user = User.create(params[:user])
    @user.save
  end

  # PUT /users/1
  # PUT /users/1.js
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    @users = User.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end

  # GET /user/1/delete
  # GET /user/1/delete.js
  def delete
    @user = User.find(params[:user_id])
  end

  # DELETE /users/1
  # DELETE /users/1.js
  def destroy
    @users = User.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    @user = User.find(params[:id])
    @error = nil

    begin
      @user.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
