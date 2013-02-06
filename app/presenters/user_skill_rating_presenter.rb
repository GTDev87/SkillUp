class UserSkillRatingPresenter < BasePresenter
  presents :user_skill_rating
  
  delegate :ratee, to: :user_skill_rating

  def skill
    skill = user_skill_rating.skill
    link_to skill.title, skill_path(skill)
  end

  def rating
    content_tag :span, class: "read_only_ballot" do
      fields = ActiveSupport::SafeBuffer.new
      
      (1..user_skill_rating.rating).each do |star|
        #may want to change this to not be a label hacky
        fields << label("rating_#{star}", "", {class: "rating", id: "#{star}"})
      end
      fields
    end
  end
end