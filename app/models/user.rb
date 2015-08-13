require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles, :dependent => :restrict_with_error
  #has_many :activity_logs, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, :presence => true,
            :length => {:maximum => 50},
            :uniqueness => true

  validates :email, :presence => true,
            :format => {:with => email_regex},
            :uniqueness => {:case_sensitive => false}

  # Automatically create the virtual attribute 'password_confirmation'
  validates :password, :presence => true,
            :confirmation => true,
            :length => {:within => 6..40}

  before_save :encrypt_password

  # Returns true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def display_field
    self.username
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
