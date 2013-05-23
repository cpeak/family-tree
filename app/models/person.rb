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
    @name = "#{first_name} #{middle_name} #{last_name} "
  end

  def born 
    dob.to_s(:pretty) if present? rescue ''
  end

  def birth 
    @born_pretty = 'Born '
    @born_pretty += dob.to_s(:pretty) if present? rescue ''
    if birthplace.present?
      @born_pretty += " in #{birthplace}"
    else
      @born_pretty
    end
  end

  def died
    dod.to_s(:pretty) if present? rescue ''
  end

  def age
    if dob.present? and dod.present?
      ((dod.year*12+dod.month) - (dob.year*12+dob.month))/12
    else 
      ''
    end
  end

  def death
    @death = ''
    @death += "Died #{died}" if died.present?
    if age.present? 
      @death += " at age #{age}"
    else
      @death = @death
    end
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

