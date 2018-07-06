require "rails_helper"

RSpec.feature "Note", :type => :feature do

  describe "User Log in" do
    let(:user) {User.new(email: "example@gmail.com", password: "password")}

    before(:each) do
      visit new_user_registration_path

      fill_in "Email",  with: user.email
      fill_in "Password",  with: user.password
      fill_in "Password confirmation", with: user.password

      click_button "Sign up"
    end

    describe "Creating a note" do
      it "allows a user to create a note" do
        notepad = Notepad.create(title: "My notepad")

        visit new_note_path

        find("#note_title", visible: false).set "My note"
        find('#note_notepad_id').find(:xpath, 'option[1]').select_option
        find("#ckeditor_text_area", visible: false).set "My first note"
        click_button "Create"

        expect(page).to have_content "My note"
      end
    end

    describe "Editing the note" do
      it "allows a user to edit the note" do
        notepad = Notepad.create(title: "New notepad")
        note = Note.create(title: "First note", text: "My edited note", notepad_id: notepad.id)

        visit "/notes/#{note.id}/edit"

        find("#note_title", visible: false).set "My new note"
        click_button "Create"

        expect(page).to have_content "My new note"
      end
    end

    describe "Show the note" do
      it "allows a user to show the note" do
        notepad = Notepad.create(title: "New notepad")
        note = Note.create(title: "First note", text: "My first note", notepad_id: notepad.id)

        visit notes_path
        click_link "First note"

        expect(page).to have_content "My first note"
      end
    end

    describe "Destroying the note" do
      #Pending because Rack::Test does not support JS
      xit "allows a user to destroy the note" do
        notepad = Notepad.create(title: "New notepad")
        note = Note.create(title: "First note", text: "My edited note", notepad_id: notepad.id)

        visit "/notes/#{note.id}"
        click_link "Delete"

        expect(page).to have_content "The Note was successfully deleted"
      end
    end
  end
end
