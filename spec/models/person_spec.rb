require 'spec_helper'
require 'person'

describe 'birth' do
  it 'outputs a string of their birthday' do
    Person.new(:first_name => 'John', :dob => '1981-08-07')
    Person.birth.should == "Born August 7, 1981"
  end
end




#describe 'hello' do
#  it 'relates a parent to a child' do
#    Person.new(:first_name => 'John', :last_name => 'Doe')
#    Person.new(:first_name => 'Billy', :last_name => 'Doe')
#    Relationship.new(:relationship_type_id => 1, :person_id => 1, :related_person_id => 2)
#    Person.age.should == ['Billy']
#  end
#end
