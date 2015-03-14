class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :role

  validates :user_id, presence: true, :uniqueness => {:scope => [:project_id]}
  validates :project_id, presence: true

end
