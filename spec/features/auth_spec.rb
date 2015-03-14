require "rails_helper"

feature "authorization" do
  feature "registration#new" do

    scenario "register wit valid info" do

      visit root_path
      click_on "user-registration-action"
      fill_in :user_first_name, with: "Momo"
      fill_in :user_last_name, with: "Eskie"
      fill_in :user_email, with: "momo@eskie.com"
      fill_in :user_password, with: "momolove"
      fill_in :user_password_confirmation, with: "momolove"
      click_on "submit-user"

      expect(page).to have_content("Sign Out")
      expect(page.current_path).to eq(root_path)

    end

    scenario "register with invalid info" do

      visit root_path
      click_on "user-registration-action"
      fill_in :user_first_name, with: "Momo"
      fill_in :user_email, with: "momo@eskie.com"
      fill_in :user_password, with: "momolove"
      click_on "submit-user"

      expect(page).to have_content("errors prohibited")
      expect(page.current_path).to eq(signup_path)

    end
  end

  feature "signin" do

    scenario "sign in with valid info" do
      User.create!(
        first_name: "Momo",
        last_name: "Eskie",
        email: "momo@eskie.com",
        password: "momolove",
        password_confirmation: "momolove",
      )

      visit root_path
      click_on "user-signin-action"
      fill_in :email, with: "momo@eskie.com"
      fill_in :password, with: "momolove"
      click_on "submit-user"

      expect(page).to have_content("Sign Out")
      expect(page.current_path).to eq(root_path)
    end

    scenario "sign in with invalid info" do

      visit root_path
      click_on "user-signin-action"
      fill_in :email, with: "rusty@gmail.com"
      fill_in :password, with: ""
      click_on "submit-user"

      expect(page).to have_content("Username / password combination is invalid")
      expect(page).to have_content("Sign In")
      expect(page.current_path).to eq(signin_path)

    end
  end

  feature "signout" do

    scenario "user signs out" do
      User.create!(
        first_name: "Momo",
        last_name: "Eskie",
        email: "momo@eskie.com",
        password: "momolove",
        password_confirmation: "momolove",
      )

      visit root_path
      click_on "user-signin-action"
      fill_in :email, with: "momo@eskie.com"
      fill_in :password, with: "momolove"
      click_on "submit-user"
      click_on "user-signout-action"

      expect(page).to have_content("Sign In")
      expect(page.current_path).to eq(root_path)
    end
  end

end
