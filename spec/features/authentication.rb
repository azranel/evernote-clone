require "rails_helper"

RSpec.feature "Authentication", :type => :feature do

  describe "User sign up" do
    it "allows user to sign up" do
      visit new_user_registration_path

      fill_in "Email", with: "newuser123@example.com"
      fill_in "Password", with: "userpassword"
      fill_in "Password confirmation", with: "userpassword"
      click_button "Sign up"

      expect(page).to have_content "Welcome! You have signed up successfully"
    end

    it "allows user to sign up" do
      visit new_user_registration_path

      fill_in "Email", with: "newuser123@example.com"
      fill_in "Password", with: "userpassword"
      fill_in "Password confirmation", with: "wrongpassword"
      click_button "Sign up"

      expect(page).to have_no_content "Welcome! You have signed up successfully"
    end
  end

  describe "User log in" do
    it "allows user to log in" do
      user = User.new(email: "newuser@example.com", password: "userpassword").save

      visit new_user_session_path

      fill_in "Email", with: "newuser@example.com"
      fill_in "Password", with: "userpassword"
      click_button "Log in"

      expect(page).to have_content "Signed in successfully"
    end

    it "does not allow the user to log in" do
      user = User.new(email: "newuser@example.com", password: "userpassword").save

      visit new_user_session_path

      fill_in "Email", with: "newuser@example.com"
      fill_in "Password", with: "password123"
      click_button "Log in"

      expect(page).to have_no_content "Signed in successfully"
    end
  end
end
