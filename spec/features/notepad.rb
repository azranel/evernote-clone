require "rails_helper"

RSpec.feature "Notepad", :type => :feature do
  describe "User Log in" do
    let(:user) {User.new(email: "example@gmail.com", password: "password")}

    before(:each) do
      visit new_user_registration_path

      fill_in "Email",  with: user.email
      fill_in "Password",  with: user.password
      fill_in "Password confirmation", with: user.password

      click_button "Sign up"
    end

    describe "Creating a notepad" do
      it "allows a user to create a notepad" do
        visit new_notepad_path

        find("#notepad_title", visible: false).set "Notepad 1"
        click_button "Create"

        expect(page).to have_content "Notepad 1"
      end
    end

    describe "Editing the notepad" do
      it "allows a user to edit the notepad" do
        notepad = Notepad.create(title: "My new notepad")

        visit "/notepads/#{notepad.id}/edit"

        find("#notepad_title", visible: false).set "Notepad 2"
        click_button "Create"

        expect(page).to have_content "Notepad 2"
      end
    end

    describe "Show the notepad" do
      it "allows a user to show the notepad" do
        notepad = Notepad.create(title: "My new notepad")

        visit notepads_path
        click_link "My new notepad"

        expect(page).to have_content "My new notepad"
      end
    end

    describe "Destroying the notepad" do
      # Pending because Rack::Test does not support JS
      xit "allows a user to destroy the notepad" do
        notepad = Notepad.create(title: "My new notepad")

        visit "/notepads/#{notepad.id}"
        click_link "Delete"

        expect(page).to have_content "The Notepad was successfully deleted"
      end
    end
  end
end
