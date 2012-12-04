class UserPresenter < BasePresenter
  presents :user
  delegate :username, to: :user
  
  #NEEDS TESTS
  def avatar
  	handle_none user.avatar? do
      image_tag(avatar_name, class: "avatar")
    end
  end

  def full_name
    user.first_name + " " + user.last_name
  end


  def age
  	handle_none user.date_of_birth? do
  	  dob = user.date_of_birth
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end

  def address
  	handle_none user.address do
      user.address
    end
  end

  def bio
    handle_none user.bio do
      markdown(user.bio)
    end
  end

private

  def handle_none(value)
    if value.present?
      yield
    else
      h.content_tag :span, "None given", class: "none"
    end
  end


  def avatar_name
    if user.avatar
      user.avatar.url(:thumb)
    else
      nil
    end
  end
end