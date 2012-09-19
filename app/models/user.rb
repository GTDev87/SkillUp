class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  field :username
  attr_accessible :username
  validates_presence_of :username
  validates_uniqueness_of :username
  
  field :email
  attr_accessible :email
  validates_presence_of :email
  validates_uniqueness_of :email
  
  field :password_digest
  attr_accessible :password
  attr_accessible :password_confirmation
  has_secure_password
  
  
  embeds_many :skill_inherents
  embeds_many :tasks
  
  def self.find_by_email(email)
    where(:email => email).first
  end
end