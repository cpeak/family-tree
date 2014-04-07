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

describe 'parent relationship' do
  it 'determines a parent to given person' do
    son = Person.new(:id => 1, :first_name => 'Luke')
    father = Person.new(:id => 2, :first_name => 'Anakin')
    relation = Relationship.new(:relationship_type_id => 1, :person_id => 2, :related_person_id => 1)

    son.listParents.should == ['Anakin']
  end
end
