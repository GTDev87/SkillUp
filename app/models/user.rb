class User
  include Mongoid::Document
  
  field :username
  validates_presence_of :username
  
  field :email
  validates_presence_of :email
  
  embeds_many :skill_inherents
  embeds_many :tasks
end
