class UserRole < ActiveRecord::Base
  attr_accessible :user_id, :role_id

  validates :user_id, :presence => true
  validates :role_id, :presence => true

  belongs_to :user
  belongs_to :role

  def display_field
    "#{self.user.username} - #{self.role.name}"
  end
end
