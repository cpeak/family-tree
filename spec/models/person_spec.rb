require 'spec_helper'
require 'person'

describe 'birth' do
  it 'outputs a string of their birthday' do
    person = Person.new(:first_name => 'John', :dob => '1981-08-07')
    person.dateBorn.should == "August  7, 1981"
  end
end

