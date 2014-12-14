require 'rails_helper'

feature 'Users' do

  scenario "User can create a user" do

    visit root_path
    click_on "get-users-index"
    click_on "create-user-new-action"
    fill_in "first-name-field", with: "Momo"
    fill_in "last-name-field", with: "Choi"
    fill_in "email-field", with: "momo@gmail.com"
    click_on "submit-user"

    expect(page).to have_content("Momo")
    expect(page).to have_content("Choi")
    expect(page).to have_content("momo@gmail.com")

  end

  scenario "User must enter in first name" do

    visit root_path
    click_on "get-users-index"
    click_on "create-user-new-action"
    fill_in "last-name-field", with: "Choi"
    fill_in "email-field", with: "momo@gmail.com"
    click_on "submit-user"
    expect(page).to have_content("1 error prohibited this user from being saved")

    fill_in "first-name-field", with: "Momo"
    click_on "submit-user"

    expect(page).to have_content("Momo")
  end

  scenario "User must enter both first and last name" do

    visit root_path
    click_on "get-users-index"
    click_on "create-user-new-action"
    fill_in "email-field", with: "foxy@gmail.com"
    click_on "submit-user"
    expect(page).to have_content("2 errors prohibited this user from being saved")

    fill_in "last-name-field", with: "Fox"
    click_on "submit-user"
    expect(page).to have_content("1 error prohibited this user from being saved")

    fill_in "first-name-field", with: "Artic"
    click_on "submit-user"
    expect(page).to have_content("Artic")
  end

  scenario "User can't enter the same email as another user" do

    user = User.create!(
    first_name: "Momo",
    last_name: "Eskie",
    email: "momo@gmail.com"
    )

    visit root_path
    click_on "get-users-index"
    click_on "create-user-new-action"
    fill_in "first-name-field", with: "Momo"
    fill_in "last-name-field", with: "Eskie"
    fill_in "email-field", with: "momo@gmail.com"
    click_on "submit-user"

    expect(page).to have_content("Email has already been taken")

    fill_in "email-field", with: "test@gmail.com"
    click_on "submit-user"
    expect(page).to have_content("Eskie")

  end

  scenario "User can edit a user" do
    user = User.create!(
    first_name: "Momo",
    last_name: "Eskie",
    email: "momo@gmail.com"
    )

    visit root_path
    click_on "get-users-index"
    expect(page).to have_content("momo@gmail.com")
    click_on "edit-user-#{user.id}-action"
    fill_in "first-name-field", with: "Mimi"
    click_on "submit-user"

    expect(page).to have_content("Mimi")
    expect(page).to have_no_content("Momo")
  end

end
