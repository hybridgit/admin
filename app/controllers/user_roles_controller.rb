class UserRolesController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  # GET /user_roles
  # GET /user_roles.xml
  def index
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => UserRolesDatatable.new(view_context), :parent => @user }
    end
  end

  # GET /user_roles/1
  # GET /user_roles/1.xml
  def show
    @user_role = UserRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user_role }
    end
  end

  # GET /user_roles/new
  # GET /user_roles/new.xml
  def new
    @user = User.find(params[:user_id])
    @user_role = UserRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user_role }
    end
  end

  # GET /user_roles/1/edit
  def edit
    @user_role = UserRole.find(params[:id])
  end

  # POST /user_roles
  # POST /user_roles.xml
  def create
    @user = User.find(params[:user_id])
    @user_role = @user.user_roles.build(params[:user_role])

    respond_to do |format|
      if @user_role.save
        format.html { redirect_to(user_role_path(@user_role.user, @user_role), :notice => 'User role was successfully created.') }
        format.xml { render :xml => user_role_path(@user_role.user, @user_role), :status => :created, :location => @user_role }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_roles/1
  # PUT /user_roles/1.xml
  def update
    @user_role = UserRole.find(params[:id])

    respond_to do |format|
      if @user_role.update_attributes(params[:user_role])
        format.html { redirect_to(user_role_path(@user_role.user, @user_role), :notice => 'User role was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_roles/1
  # DELETE /user_roles/1.xml
  def destroy
    @user_role = UserRole.find(params[:id])
    @user_role.destroy

    respond_to do |format|
      format.html { redirect_to(user_roles_url) }
      format.xml { head :ok }
    end
  end
end
