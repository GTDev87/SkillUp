class Mission
  include Mongoid::Document

  attr_accessible :title
  field :title, type: String
  validates_presence_of :title
  
  field :lowercase_title
  before_create :lower_title_case
  
  attr_accessible :description
  field :description, type: String
  
  has_many :mission_skills, inverse_of: :mission, autosave: true
  accepts_nested_attributes_for :mission_skills, allow_destroy: true
  attr_accessible :mission_skills_attributes
  
  def ability_points
    ability = Hash.new(0)
    skill_points.each do |title, points_multiplier|
      ability_points_multiplied = Skill.find_by(title: title).ability_points.inject({}) do |agg_points, (ability_title, ability_points)| 
        agg_points[ability_title] = ability_points * points_multiplier
        agg_points
      end
      ability = ability.merge(ability_points_multiplied) do |k, agg_ability, mult_ability|
        agg_ability + mult_ability
      end
    end
    ability
  end
  
  def skill_points
    mission_skills.each_with_object(Hash.new(0)) do |mission_skill, skills| 
      skills[mission_skill.skill.title] += mission_skill.points
    end
  end
  
  def self.search_titles(mission_title_name)
    Mission.any_of({lowercase_title: /.*#{mission_title_name.downcase}.*/ }).sort(lowercase_title: 1).entries  
  end
  
private
  def lower_title_case
    self.lowercase_title = self.title.downcase
  end
end
