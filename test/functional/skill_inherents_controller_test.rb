require 'test_helper'

class SkillInherentsControllerTest < ActionController::TestCase
  setup do
    @skill_inherent = skill_inherents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skill_inherents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skill_inherent" do
    assert_difference('SkillInherent.count') do
      post :create, skill_inherent: {  }
    end

    assert_redirected_to skill_inherent_path(assigns(:skill_inherent))
  end

  test "should show skill_inherent" do
    get :show, id: @skill_inherent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skill_inherent
    assert_response :success
  end

  test "should update skill_inherent" do
    put :update, id: @skill_inherent, skill_inherent: {  }
    assert_redirected_to skill_inherent_path(assigns(:skill_inherent))
  end

  test "should destroy skill_inherent" do
    assert_difference('SkillInherent.count', -1) do
      delete :destroy, id: @skill_inherent
    end

    assert_redirected_to skill_inherents_path
  end
end
