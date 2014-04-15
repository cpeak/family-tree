class Person < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :dob, :dod, :sex, :photo, :birthplace, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at


  validates :dob, allow_nil: true, format: {
    with: /\A\d{4}(-\d{1,2}(-\d{1,2})?)?\z/
  }

  has_many :notes
  has_many :relationships, :dependent => :destroy
  has_many :reverse_relationships, :dependent => :destroy, class_name: 'Relationship', foreign_key: 'related_person_id'
  has_attached_file :photo

  has_many :person_images, :dependent => :destroy
  accepts_nested_attributes_for :person_images, :reject_if => lambda { |t| t['trip_image'].nil? }

  accepts_nested_attributes_for :relationships

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def all_relationships
    relationships | reverse_relationships
  end

  def fullName
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def dateBorn
    dob.to_s(:pretty) if present? rescue ''
  end

  def inBirthplace
    [" in ", birthplace].join if birthplace.present?
  end

  def bornOnWithLocation
    ['Born', dateBorn, inBirthplace].compact.join(' ')
  end

  def dateDied
    dod.to_s(:pretty) if present? rescue ''
  end

  def diedOnAtAge
    ["Died", dateDied, ageDiedPretty ].join(' ') if dateDied.present?
  end

  def ageDied
    if dob.present? and dod.present?
      ((dod.year*12+dod.month) - (dob.year*12+dob.month))/12
    else
      ''
    end
  end

  def ageDiedPretty
    ["at age", ageDied] if ageDied.present?
  end

  def relatives
    relative = []
    self.all_relationships.each do |filter|
      if filter.person_id == self.id
        relative << (Person.find filter.related_person_id)
      end
    end
    return relative
  end

  def listSpouses
    spouse = []
    self.all_relationships.each do |filter|
      if filter.person_id == self.id && filter.relationship_type_id == 2
        spouse << (Person.find filter.related_person_id)
      elsif filter.related_person_id == self.id && filter.relationship_type_id == 2
        spouse << (Person.find filter.person_id)
      end
    end
    return spouse
  end


  def listParents
    parents = []
    self.all_relationships.each do |filter|
      if filter.relationship_type_id == 1 && filter.related_person_id == self.id
        parents << (Person.find filter.person_id)
      end
    end
    return parents
  end

  def listSiblings
    siblings = []
    self.all_relationships.each do |filter|
      if filter.relationship_type_id == 3 && filter.related_person_id == self.id
        siblings << (Person.find filter.person_id)
      elsif filter.relationship_type_id == 3 && filter.person_id == self.id
        siblings << (Person.find filter.related_person_id)
      end
    end
    return siblings
  end

  def listChildren
    children = []
    self.all_relationships.each do |filter|
      if filter.relationship_type_id == 1 && filter.related_person_id != self.id
        children << (Person.find filter.related_person_id)
      end
    end
    return children
  end

  def averageAge
    ages = []
    self.find_each do |person|
      if ageDied.present?
        ageDied >> ages
      end
    end
  end
end

