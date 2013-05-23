require 'spec_helper'

describe "notes/new" do
  before(:each) do
    assign(:note, stub_model(Note,
      :person_id => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notes_path, "post" do
      assert_select "input#note_person_id[name=?]", "note[person_id]"
      assert_select "textarea#note_content[name=?]", "note[content]"
    end
  end
end
