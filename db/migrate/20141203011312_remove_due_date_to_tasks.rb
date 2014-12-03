class RemoveDueDateToTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :due_date, :string
  end
end
