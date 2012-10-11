class Skill
  include Mongoid::Document 
  
  #attr_accessible :title
  field :title, type: String
  validates_presence_of :title
  
  field :lowercase_title
  before_create :lower_title_case
  
  field :description, type: String
  
  has_and_belongs_to_many :skills
  
  def self.search_titles(skill_title_name)
    Skill.any_of({lowercase_title: /.*#{skill_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end  
end
