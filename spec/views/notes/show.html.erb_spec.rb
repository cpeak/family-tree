require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
  end
end
