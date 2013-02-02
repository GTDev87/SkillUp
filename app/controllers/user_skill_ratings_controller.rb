# app/controllers/user_skill_ratings_controller.rb
class UserSkillRatingsController < ApplicationController
  before_filter :get_user
  
  def new
    @user_skill_rating = @user.user_skill_ratings.build
  end

  def create
  	
    @user_skill_rating = @user.user_skill_ratings.create(params[:user_skill_rating])
    respond_to do |format|
      format.html { redirect_to user_user_skill_rating_url(@user, @user_skill_rating) }
      format.js
    end
  end

  def index
    @user_skill_ratings_paginator = my_paginate(@user.user_skill_ratings.desc(:created_at), :user_skill_rating_next_element_id)
  end

  def destroy
    @user_skill_rating = UserSkillRating.find(params[:id])
    @user_skill_rating.destroy
  end

private

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]
    redirect_to root_path unless defined?(@user)
  end
end