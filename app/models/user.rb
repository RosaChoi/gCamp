class User < ActiveRecord::Base
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :roles, through: :memberships

  validates :first_name, :last_name, presence:true
  validates :email, uniqueness: { case_sensitive: false }, presence:true
  has_secure_password

end
