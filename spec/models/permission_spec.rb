require 'spec_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

RSpec::Matchers.define :allow_param do |*args|
  match do |permission|
    permission.allow_param?(*args).should be_true
  end
end

describe Permission do
  describe "as guest" do
    subject { Permission.new(nil) }
    
    it { should_not allow(:users, :index) }
    it { should_not allow(:users, :show) }
    it { should     allow(:users, :new) }
    it { should     allow(:users, :create) }
    it { should_not allow(:users, :edit) }
    it { should_not allow(:users, :update) }
    it { should_not allow(:users, :destroy) }

    it { should allow(:sessions, :new) }
    it { should allow(:sessions, :create) }
    it { should allow(:sessions, :destroy) }
    
    it { should     allow(:skills, :index) }
    it { should     allow(:skills, :show) }
    it { should_not allow(:skills, :new) }
    it { should_not allow(:skills, :create) }
    it { should_not allow(:skills, :edit) }
    it { should_not allow(:skills, :update) }
    it { should_not allow(:skills, :destroy) }

    it { should     allow(:missions, :index) }
    it { should     allow(:missions, :show) }
    it { should_not allow(:missions, :new) }
    it { should_not allow(:missions, :create) }
    it { should_not allow(:missions, :edit) }
    it { should_not allow(:missions, :update) }
    it { should_not allow(:missions, :destroy) }

    it { should     allow_param(:user, :username) }
    it { should     allow_param(:user, :email) }
    it { should     allow_param(:user, :password) }
    it { should     allow_param(:user, :password_confirmation) }
  end
  
  describe "as member" do
    let(:user) { create(:user, admin: false) }
    let(:other_user) { build(:user) }
    subject { Permission.new(user) }
    
    it { should_not allow(:users, :index) }
    it { should     allow(:users, :show, user) }
    it { should_not allow(:users, :show, other_user) }
    it { should     allow(:users, :new) }
    it { should     allow(:users, :create) }
    it { should     allow(:users, :edit, user) }
    it { should     allow(:users, :update, user) }
    it { should_not allow(:users, :edit, other_user) }
    it { should_not allow(:users, :update, other_user) }
    it { should_not allow(:users, :destroy) }
    
    it { should     allow_param(:user, :first_name) }
    it { should     allow_param(:user, :last_name) }
    it { should     allow_param(:user, :date_of_birth) }
    it { should     allow_param(:user, :address) }
    it { should     allow_param(:user, :bio) }
    it { should     allow_param(:user, :avatar) }

    it { should     allow_param(:user_mission, :id) }
    it { should     allow_param(:user_mission, :_destroy) }
    it { should     allow_param(:user_mission, :mission_title) }

    it { should     allow_param(:user_skill_rating, :id) }
    it { should     allow_param(:user_skill_rating, :_destroy) }
    it { should     allow_param(:user_skill_rating, :ratee_username) }
    it { should     allow_param(:user_skill_rating, :rating) }
    it { should     allow_param(:user_skill_rating, :skill_title) }

    it { should allow(:sessions, :new) }
    it { should allow(:sessions, :create) }
    it { should allow(:sessions, :destroy) }
    
    it { should     allow(:skills, :index) }
    it { should     allow(:skills, :show) }
    it { should_not allow(:skills, :new) }
    it { should_not allow(:skills, :create) }
    it { should_not allow(:skills, :edit) }
    it { should_not allow(:skills, :update) }
    it { should_not allow(:skills, :destroy) }

    it { should     allow(:missions, :index) }
    it { should     allow(:missions, :show) }
    it { should     allow(:missions, :new) }
    it { should     allow(:missions, :create) }
    it { should_not allow(:missions, :edit) }
    it { should_not allow(:missions, :update) }
    it { should_not allow(:missions, :destroy) }
  end
  
  describe "as admin" do
    subject { Permission.new(build(:user, admin: true)) }
    
    it { should allow(:anything, :here) }
    it { should allow_param(:topic, :name) }
  end
end