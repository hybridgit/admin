class Role < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :user_roles, :dependent => :restrict_with_error
  has_many :users, :through => :user_roles, :dependent => :restrict_with_error

  has_many :role_permissions, :dependent => :destroy
  has_many :permissions, :through => :role_permissions, :dependent => :restrict_with_error

  def has_permission?(controller, action)
    self.permissions.where(:controller => controller, :action => action).count > 0
  end

  def display_field
    self.name
  end
end
