require 'rails_helper'

feature 'Tasks' do

  scenario "Users can create tasks" do
    Project.create!(name:"Train Momo")

    visit root_path
    click_on "Projects"
    click_on "Train Momo"
    click_on "0 Tasks"
    click_on "create-task-new-action"
    fill_in "Description", with: "How to fetch"
    click_on "submit-task"

    expect(page).to have_no_content("New Task")
    expect(page).to have_content("Task was successfully created")
  end

  scenario "User creates a task without a description first" do
    Project.create!(name:"Train Momo")

    visit root_path
    click_on "Projects"
    click_on "Train Momo"
    click_on "0 Tasks"
    click_on "create-task-new-action"
    click_on "submit-task"

    expect(page).to have_content("1 error prohibited this Task from being saved:")
    fill_in "Description", with: "How to fetch"
    click_on "submit-task"
    expect(page).to have_content("How to fetch")
  end

  scenario 'Edit a task' do
    project = Project.create!(name: "Testing editing task")
    project.tasks.create!(description: "Task to Edit")

    visit root_path
    click_on "Projects"
    click_on "Testing editing task"
    click_on "1 Task"
    click_on "Edit"
    fill_in :task_description, with: 'Edited Task'
    click_on "submit-task"

    expect(page).to have_content("Edited Task")
    expect(page).to have_content("Task was successfully updated")
  end

  scenario 'List all tasks' do
    project = Project.create!(name: "Testing listing tasks")
    project.tasks.create!(description: "Task1")
    project.tasks.create!(description: "Task2")
    project.tasks.create!(description: "Task3")

    visit root_path
    click_on "Projects"
    click_on "Testing listing tasks"
    click_on "3 Tasks"

    expect(page).to have_content("Task1")
    expect(page).to have_content("Task2")
    expect(page).to have_content("Task3")
  end

  scenario 'Show a specific task' do
    project = Project.create!(name: "Testing showing a task")
    project.tasks.create!(description: "Show this task")

    visit root_path
    click_on "Projects"
    click_on "Testing showing a task"
    click_on "1 Task"
    click_on "Show"
    expect(page).to have_content("Show this task")
  end

  scenario 'Delete task' do
    project = Project.create!(name: "Testing deleting a task")
    project.tasks.create!(description: "Delete this task")

    visit root_path
    click_on "Projects"
    click_on "Testing deleting a task"
    click_on "1 Task"
    click_on "Delete"

    expect(page).to_not have_content("Delete this task")
    expect(page).to have_content("Task was successfully destroyed")
  end

end
