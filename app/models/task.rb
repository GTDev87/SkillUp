class Task
  include Mongoid::Document
 
  embedded_in :user, :inverse_of => :tasks
  
  has_one :mission
  validates_presence_of :mission
end
