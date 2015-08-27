class Permission < ActiveRecord::Base
  has_many :role_permissions, :dependent => :restrict_with_error
  has_many :roles, :through => :role_permissions, :dependent => :restrict_with_error

  attr_accessible :controller, :action

  def self.controllers
    Rails.application.eager_load!
    @controllers = []
    ApplicationController.descendants.each do |controller|
      @controllers << controller.controller_name
    end
    @controllers
  end

  def self.actions(controller)
    Rails.application.eager_load!
    @controller = ApplicationController.descendants.find do |ctrl|
      ctrl.controller_name == controller
    end

    @methods = []
    @controller.action_methods.map do |action|
      @methods << action.to_s unless SessionsHelper.public_instance_methods.include? action.to_sym
    end
    @methods
  end

  def display_field
    "#{self.controller} - #{self.action}"
  end
end
