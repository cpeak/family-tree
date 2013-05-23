require 'spec_helper'

describe "notes/edit" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :person_id => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", note_path(@note), "post" do
      assert_select "input#note_person_id[name=?]", "note[person_id]"
      assert_select "textarea#note_content[name=?]", "note[content]"
    end
  end
end
