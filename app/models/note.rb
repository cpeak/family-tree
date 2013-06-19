class Note < ActiveRecord::Base
  attr_accessible :content, :person_id
  belongs_to :person

  def fullName 
    (Person.find person_id).fullName
  end

end
