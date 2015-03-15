require 'rails_helper'

feature 'Users' do

  scenario "User can create a user" do

    visit root_path
    click_on "get-users-index"
    click_on "create-user-new-action"
    fill_in "first-name-field", with: "Momo"
    fill_in "last-name-field", with: "Choi"
    fill_in "email-field", with: "momo@gmail.com"
    fill_in "password-field", with: "momolove"
    fill_in "password-confirmation-field", with: "momolove"
    click_on "submit-user"

    expect(page).to have_content("Momo")
    expect(page).to have_content("Choi")
    expect(page).to have_content("momo@gmail.com")
  end

  scenario 'Edit a user' do
    user = User.create!(
    first_name: "Momo",
    last_name: "Eskie",
    email: "momo@gmail.com",
    password: "momolove",
    password_confirmation: "momolove",
   )

   visit root_path
   click_on "get-users-index"
   click_on "edit-user-#{user.id}-action"
   fill_in "first-name-field", with: 'Mimi'
   fill_in "last-name-field", with: "Poodle"
   click_on "submit-user"

   expect(page).to have_content("Mimi Poodle")
   expect(page).to have_content("User was successfully updated")
 end

  scenario 'List all users' do
    User.create!(
      first_name: "Momo",
      last_name: "Eskie",
      email: "momo@gmail.com",
      password: "momolove",
      password_confirmation: "momolove",
    )
    User.create!(
      first_name: "Rusty",
      last_name: "Steele",
      email: "rusty@steele.com",
      password: "coltrusty",
      password_confirmation: "coltrusty",
    )
    User.create!(
      first_name: "Mimi",
      last_name: "Poodle",
      email: "mimi@poodle.com",
      password: "mimipoodle",
      password_confirmation: "mimipoodle",
    )

    visit root_path
    click_on "Users"

    expect(page).to have_content("Momo Eskie")
    expect(page).to have_content("Rusty Steele")
    expect(page).to have_content("Mimi Poodle")
  end

  scenario 'Show a specific user' do
    User.create!(
      first_name: "Momo",
      last_name: "Eskie",
      email: "momo@gmail.com",
      password: "momolove",
      password_confirmation: "momolove",
    )

    User.create!(
      first_name: "Rosa",
      last_name: "Me",
      email: "rosa@me.com",
      password: "memememe",
      password_confirmation: "memememe",
    )

    visit root_path
    click_on "Users"
    click_on "Momo Eskie"
    expect(page).to have_content("Momo Eskie")
    expect(page).to_not have_content("Rosa Me")
  end

  scenario 'Delete user' do
    User.create!(
      first_name: "Rosa",
      last_name: "Me",
      email: "rosa@me.com",
      password: "memememe",
      password_confirmation: "memememe",
    )

    visit root_path
    click_on "Users"
    click_on "Rosa Me"
    click_on "Edit"
    click_on "destroy-user-action"

    expect(page).to_not have_content("Rosa Me")
    expect(page).to have_content("User was successfully destroyed.")
  end





end
