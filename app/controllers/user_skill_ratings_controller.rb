# app/controllers/user_skill_ratings_controller.rb
class UserSkillRatingsController < ApplicationController
  before_filter :get_user
  
  def new
    @user_skill_rating = @user.user_skill_ratings.build
    respond_to do |format|
      format.html
      format.js { @parent_name = "user"; render 'ref_ajax_partials/new.js.erb' }
    end
  end

  def create
    @user_skill_rating = @user.user_skill_ratings.create(params[:user_skill_rating])
    respond_to do |format|
      format.js { render 'ref_ajax_partials/create.js.erb' }
    end
  end

  def index
    @user_skill_ratings_paginator = my_paginate(@user.user_skill_ratings, :user_skill_rating_next_element_id)
    
    respond_to do |format|
      format.js do 
        @parent_name = "user"
        render 'ref_ajax_partials/more.js.erb'
      end
    end
  end

  def destroy
    @user_skill_rating = UserSkillRating.find(params[:id])
    @user_skill_rating.destroy
    respond_to do |format|
      format.js { @object = @user_skill_rating; render 'ref_ajax_partials/destroy.js.erb' }
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