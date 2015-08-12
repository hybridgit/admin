class RolePermission < ActiveRecord::Base
  belongs_to :role
  belongs_to :permission

  def permission_name
    [self.permission.controller, self.permission.action].join("-")
  end

  def display_field
    "#{self.role.name} - #{self.permission.display_field}"
  end
end
