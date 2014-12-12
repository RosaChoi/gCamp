class Task < ActiveRecord::Base

  validates :description, presence:true

  validate :due_in_future, on: :create

  def due_in_future
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "cannot be in the past")
    end
  end

end
