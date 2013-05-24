class Note < ActiveRecord::Base
  attr_accessible :content, :person_id
  belongs_to :person



  def name 
    (Person.find person_id).name
  end

end
