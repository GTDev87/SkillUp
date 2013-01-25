class UserSkillRating
  include Mongoid::Document
  
  field :rating, type: Integer
  validates_presence_of :rating

  belongs_to :rater, class_name: "User", inverse_of: :user_skill_ratings
  validates_presence_of :rater

  belongs_to :ratee, class_name: "User", inverse_of: :inverse_user_skill_ratings
  validates_presence_of :ratee

  belongs_to :skill, inverse_of: :user_skill_ratings
  validates_presence_of :skill
  
  validate :not_rating_self

  def not_rating_self
    #HACK ALERT!!! don't know why need rater.try(:username) #may want to fix
    errors.add(:user, "Cannot Rate Self") if rater.try(:username) == ratee_username
  end

  #all the virtual methods need testing
  def skill_title
    skill.try(:title)
  end

  def skill_title=(title)
    self.skill = Skill.find_by(title: title) if title.present?
  end

  def ratee_username
    ratee.try(:username)
  end

  def ratee_username=(username)
    self.ratee = User.find_by(username: username) if username.present?
  end
end