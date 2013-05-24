class Person < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :dob, :dod

  validates :name, :presence => true
  validates :dob, allow_nil: true, format: {
    with: /\A\d{4}(-\d{1,2}(-\d{1,2})?)?\z/
  }

  has_many :notes
  has_many :relationships, :dependent => :destroy
  has_many :reverse_relationships, :dependent => :destroy, class_name: 'Relationship', foreign_key: 'related_person_id'

  def all_relationships
    relationships | reverse_relationships
  end

  def name 
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def born 
    dob.to_s(:pretty) if present? rescue ''
  end

  def birthplace_pretty
    [" in ", birthplace].join if birthplace.present?
  end

  def birth 
    ['Born', born, birthplace_pretty].compact.join(' ')
  end

  def died
    dod.to_s(:pretty) if present? rescue ''
  end

  def death
    ["Died", died, age_pretty].join(' ') if died.present?
  end

  def age
    if dob.present? and dod.present?
      ((dod.year*12+dod.month) - (dob.year*12+dob.month))/12
    else 
      ''
    end
  end

  def age_pretty
    ["at age", age] if age.present?
  end


  def spouses
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


  def parents
    parents = []
    self.all_relationships.each do |filter|
      if filter.relationship_type_id == 1 && filter.related_person_id == self.id
        parents << (Person.find filter.person_id)
      end
    end
    return parents
  end

  def siblings
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

  def children
    children = []
    self.all_relationships.each do |filter|
      if filter.relationship_type_id == 1 && filter.related_person_id != self.id
        children << (Person.find filter.related_person_id)
      end
    end
    return children
  end
end

