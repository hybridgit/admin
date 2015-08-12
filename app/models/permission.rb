class Permission < ActiveRecord::Base
  has_many :role_permissions, :dependent => :restrict_with_error
  has_many :roles, :through => :role_permissions, :dependent => :restrict_with_error

  def self.controllers
    Rails.application.eager_load!
    ApplicationController.descendants
  end

  def self.actions
    %w{index show new edit create update destroy}
  end

  def display_field
    "#{self.controller} - #{self.action}"
  end
end
