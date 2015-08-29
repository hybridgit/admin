class RelationshipsController < ApplicationController
  before_filter :authenticate
  before_filter do |c|
    c.send(:authorize, self.controller_name, self.action_name)
  end

  respond_to :html, :js

  # GET /relationships
  # GET /relationships.js

  def index
    @relationships = Relationship.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /relationships/1
  # GET /relationships/1.js
  def show
    @relationship = Relationship.find(params[:id])
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  # GET /relationships/1/edit
  def edit
    @relationship = Relationship.find(params[:id])
  end

  # POST /relationships
  # POST /relationships.js

  def create
    @relationships = Relationship.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @relationship = Relationship.create(params[:relationship])
  end

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    @relationship = Relationship.find(params[:id])
    @relationship.update_attributes(params[:relationship])
    @relationships = Relationship.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
  end

  # GET /relationship/1/delete
  # GET /relationship/1/delete.js
  def delete
    @relationship = Relationship.find(params[:relationship_id])
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationships = Relationship.paginate(:page => params[:page], :per_page => 30).order('updated_at DESC')
    @relationship = Relationship.find(params[:id])
    @error = nil

    begin
      @relationship.destroy
    rescue ActiveRecord::DeleteRestrictionError => e
      @error = e.message
    end
  end

end
