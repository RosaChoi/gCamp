class Task < ActiveRecord::Base

  validates :description, presence:true

  validate :due_in_future, on: :create

  def due_in_future
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "cannot be in the past")
    end
  end

  def due_within_week
    if self.due_date && self.due_date - Date.today <= 7
      true
    else
      false
    end
  end

end
