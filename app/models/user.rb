class User < ActiveRecord::Base
  validates :first_name, :last_name, presence:true
  validates :email, uniqueness: { case_sensitive: false }, presence:true
  has_secure_password
end
