require 'spec_helper'
require 'person'


describe 'full name' do
  it 'outputs a string of their full name' do
    person = Person.new(:first_name => 'Richard', :middle_name => 'Milhouse', :last_name => 'Nixon')
    person.fullName.should == "Richard Milhouse Nixon"
  end
end

describe 'birth' do
  it 'outputs a string of their birthday' do
    person = Person.new(:first_name => 'John', :dob => '1981-08-07')
    person.dateBorn.should == "August  7, 1981"
  end
end

describe 'death' do
  it 'outputs a string of when they died' do
    person = Person.new(:first_name => 'John', :dod => '1955-10-12')
    person.dateDied.should == "October 12, 1955"
  end
end


describe 'calculate age at death' do
  it 'determines how old they were when they died' do
    person = Person.new(:first_name => 'Bob', :dob => '1900-01-01', :dod => '1950-01-02')
    person.ageDied.should == 50
  end
end

