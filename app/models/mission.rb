class Mission
  include Mongoid::Document

  belongs_to :task, :inverse_of => :mission

  field :title, type: String
  validates_presence_of :title
  
  field :description, type: String
  
  embeds_many :skill_aptitudes
end
