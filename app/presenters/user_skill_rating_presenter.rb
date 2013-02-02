class UserSkillRatingPresenter < BasePresenter
  presents :user_skill_rating
  
  delegate :ratee, :skill, to: :user_skill_rating

  def rating

    content_tag :div, class: "read_only_ballot" do
      fields = ActiveSupport::SafeBuffer.new
      
      (1..user_skill_rating.rating).each do |star|
        #may want to change this to not be a label hacky
        fields << label("rating_#{star}", "", {class: "rating", id: "#{star}"})
      end
      fields
    end
  end
end