require 'rails_helper'

feature 'Projects' do

  scenario "Users can create projects" do

    visit root_path
    click_on "get-projects-index"
    click_on "create-project-new-action"
    fill_in "project-name-field", with: "gProject"
    click_on "submit-project"

    expect(page).to have_content("gProject")
  end

  scenario "User must enter project name" do

    visit root_path
    click_on "get-projects-index"
    click_on "create-project-new-action"
    click_on "submit-project"
    expect(page).to have_content("Name can't be blank")

    fill_in "project-name-field", with: "Puppy Project"
    click_on "submit-project"

    expect(page).to have_content("Puppy Project")
  end

  scenario "Users can list projects" do
    project = Project.create!(
    name: "Test Project A"
    )
    project = Project.create!(
    name: "Test Project B"
    )

    visit root_path
    click_on "get-projects-index"


    expect(page).to have_content("Test Project A")
    expect(page.current_path).to eq(projects_path)
  end

  scenario "User can edit and update a project" do
    project = Project.create!(
    name: "Holiday Project"
    )

    visit root_path
    click_on "get-projects-index"
    expect(page).to have_content("Holiday Project")
    click_on "Holiday Project"
    click_on "edit-project-action"
    fill_in "project-name-field", with: "X-mas Project"
    click_on "submit-project"

    expect(page).to have_content("X-mas Project")
    expect(page).to have_no_content("Holiday Project")
  end

  scenario "User can delete a project" do
    project = Project.create!(
    name: "Holiday Project"
    )

    visit root_path
    click_on "get-projects-index"
    expect(page).to have_content("Holiday Project")
    click_on "Holiday Project"
    click_on "destroy-project-action"

    expect(page).to have_no_content("Holiday Project")
    expect(page.current_path).to eq(projects_path)
  end

end
