class Permission
  
  def initialize(user)
    allow :users, [:new, :create]
    allow_param(:user, [:username, :email, :password, :password_confirmation])

    allow :missions, [:index, :show]
    allow :skills, [:index, :show]
    allow :sessions, [:new, :create, :destroy]
    #allow_param(:user, [:username, :email, :password, :password_confirmation])
    
    if user
      allow :missions, [:new, :create]
      allow :skill, [:new, :create]

      #gridfs needs test
      allow :gridfs, [:serve] do |resource_user|
        resource_user.id == user.id
      end
      
      #TESTS!!!!
      allow :user_missions, [:new, :index, :create, :destroy] do |resource_user|
        resource_user.id == user.id
      end
      allow_param(:user_mission, [:id, :_destroy, :mission_title])
      
      #TESTS!!!!
      allow :user_skill_ratings, [:new, :index, :create, :destroy] do |resource_user|
        resource_user.id == user.id
      end
      allow_param(:user_skill_rating, [:id, :_destroy, :ratee_username, :rating, :skill_title])      

      allow :users, [:edit, :update, :show] do |resource_user|
        resource_user.id == user.id
      end
      allow_param(:user, [:first_name, :last_name, :date_of_birth, :address, :bio, :avatar])
      
      #TESTS!!!
      #allow :mission, [:edit, :update] do |resource_user|
      #  resource_user..try(:id) == user.id
      #end

      #TESTS!!!
      #allow :skill, [:edit, :update] do |resource_user|
      #  resource_user.try(:id) == user.id
      #end

      allow_all if user.admin?
    end
  end
  
  
  
  #@allowed_actions contains either true or a block
  #the block is evaluated in allow? and set in allow
  
  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
  
  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[resource] ||= []
      @allowed_params[resource] += Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[resource]
      @allowed_params[resource].include? attribute
    end
  end
  
  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to? :permit
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end