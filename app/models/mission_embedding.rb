class MissionEmbedding
  include Mongoid::Document
  
  #UNTESTED RANGE
  #attr_accessible :count
  #field :count, type: Integer
  #validates_presence_of :count
  
  #belongs_to :sub_mission, class_name: "Mission", inverse_of: :super_embeddings
  #validates_presence_of :sub_mission
  
  #belongs_to :super_mission, class_name: "Mission", inverse_of: :sub_embeddings
  #validates_presence_of :super_mission
  #UNTESTED DONE
end
