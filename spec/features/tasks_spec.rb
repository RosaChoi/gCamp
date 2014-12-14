require 'rails_helper'

feature 'Users can CRUD tasks' do

  scenario "Users can create tasks" do

    visit root_path
    click_on "get-tasks-index"
    click_on "create-task-new-action"
    fill_in "Description", with: "Hug Momo"
    click_on "submit-task"

    expect(page).to have_content("Hug Momo")
    expect(page).to have_content("false")
  end

  scenario "User creates a task without a description first" do

    visit root_path
    click_on "get-tasks-index"
    click_on "create-task-new-action"
    click_on "submit-task"
    expect(page).to have_content("1 error prohibited this task")
    fill_in "Description", with: "Hug Momo"
    click_on "submit-task"

    expect(page).to have_content("Hug Momo")
  end

  scenario 'Users can view list of all tasks' do
    Task.create!(
    description: "Task1",
    )
    Task.create!(
    description: "Task2",
    )
    Task.create!(
    description: "Task3",
    )

    visit root_path
    click_on "get-tasks-index"

    expect(page).to have_content("Task1")
    expect(page).to have_content("Task2")
    expect(page).to have_content("Task3")
  end

  scenario "User can edit a task" do
    task = Task.create!(
    description: "Walk Momo"
    )

    visit root_path
    click_on "get-tasks-index"
    expect(page).to have_content("Walk Momo")
    click_on "edit-task-#{task.id}-action"
    fill_in "Description", with: "Hug Momo"
    click_on "submit-task"

    expect(page).to have_content("Hug Momo")
    expect(page).to have_no_content("Walk Momo")
  end

  scenario "Users can view a task." do
    task = Task.create!(
    description: "Train Momo how to crawl"
    )

    visit root_path
    click_on "get-tasks-index"
    expect(page).to have_content("Train Momo how to crawl")
    click_on "show-task-#{task.id}-action"

    expect(page).to have_content("Train Momo how to crawl")
    expect(page).to have_content("false")
  end

  scenario "Users can delete a task" do
    task = Task.create(
    description: "Play with Momo"
    )

    visit root_path
    click_on "get-tasks-index"
    expect(page).to have_content("Play with Momo")
    click_on "destroy-task-#{task.id}-action"

    expect(page).to have_no_content("Play with Momo")
  end

end
