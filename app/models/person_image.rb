class PersonImage < ActiveRecord::Base
  attr_accessible :caption, :person_id
  belongs_to :person
  has_attached_file :photo
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
end
