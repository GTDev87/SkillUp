class Mission
  include Mongoid::Document

  attr_accessible :title
  field :title, type: String
  validates_presence_of :title
  
  field :lowercase_title
  before_create :lower_title_case
  
  field :description, type: String
  
  embeds_many :mission_abilities
  accepts_nested_attributes_for :mission_abilities, :allow_destroy => true
  attr_accessible :mission_abilities_attributes
  
  def self.search_titles(mission_title_name)
    Mission.any_of({lowercase_title: /.*#{mission_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries  
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end
end
