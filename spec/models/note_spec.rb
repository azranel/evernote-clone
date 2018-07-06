require 'rails_helper'

RSpec.describe Note, type: :model do
  let!(:wrong_title) { "Some note aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" }
  let!(:title) { "Some note" }
  let!(:note_content) { "test123" }
  let!(:subject_title) { "note123" }
  let!(:test_notepad) { Notepad.new(title: "notepad123") }
  let!(:note) { Note.new(title: title, text: note_content, notepad: test_notepad).save }

  subject { Note.new(title: subject_title, text: note_content, notepad: test_notepad) }

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "should validate uniqueness of title" do
    subject.title = title
    expect(subject).to_not be_valid
  end

  it "should validate length of the title" do
    subject.title = wrong_title
    expect(subject).to_not be_valid
  end

  it "is not valid without a text" do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a notepad" do
    subject.notepad = nil
    expect(subject).to_not be_valid
  end

  it "should belong to one notepad" do
    t = Note.reflect_on_association(:notepad)
    expect(t.macro).to eq :belongs_to
  end
end
