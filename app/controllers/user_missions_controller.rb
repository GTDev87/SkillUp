# app/controllers/user_missions_controller.rb
class UserMissionsController < ApplicationController
  before_filter :get_user
  
  def new
    @user_mission = @user.user_missions.build
  end

  def create
    @user_mission = @user.user_missions.create(params[:user_mission])
    respond_to do |format|
      format.html { redirect_to user_user_mission_url(@user, @user_mission) }
      format.js
    end
  end

  def index
    @user_missions_paginator = my_paginate(@user.user_missions.desc(:created_at), :user_mission_next_element_id)
  end

  def destroy
    @user_mission = UserMission.find(params[:id])
    @user_mission.destroy
  end

private

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]
    redirect_to root_path unless defined?(@user)
  end
end