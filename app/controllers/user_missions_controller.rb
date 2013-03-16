# app/controllers/user_missions_controller.rb
=begin
class UserMissionsController < ApplicationController
  respond_to :json
  before_filter :get_user

  def index
    
    respond_with @user.user_missions
  end

  def show
    debugger
    respond_with UserMission.find(params[:id])
  end

  def create
    debugger
    respond_with @user.user_missions.create(params[:user_mission])
  end

  def update
    debugger
    respond_with UserMission.update(params[:id], params[:user_mission])
  end

  def destroy
    debugger
    respond_with UserMission.find(params[:id])
  end

  def current_resource
    get_user
  end

private

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]
    redirect_to root_path unless defined?(@user)
    @user
  end
end
=end
class UserMissionsController < ApplicationController
  before_filter :get_user
  
  def new
    @user_mission = @user.user_missions.build

    respond_to do |format|
      format.html
      format.js { @parent_name = "user"; render 'ref_ajax_partials/new.js.erb' }
    end
  end

  def create
    @user_mission = @user.user_missions.create(params[:user_mission])
    
    respond_to do |format|
      format.js { render 'ref_ajax_partials/create.js.erb' }
    end
  end

  def index
    @user_missions_paginator = my_paginate(@user.user_missions, :user_mission_next_element_id)

    respond_to do |format|
      format.js do 
        @parent_name = "user"
        render 'ref_ajax_partials/more.js.erb'
      end
    end
  end

  def destroy
    @user_mission = UserMission.find(params[:id])
    @user_mission.destroy

    respond_to do |format|
      format.js { @object = @user_mission; render 'ref_ajax_partials/destroy.js.erb' }
    end
  end

  def current_resource
    get_user
  end

private

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]
    redirect_to root_path unless defined?(@user)
    @user
  end
end