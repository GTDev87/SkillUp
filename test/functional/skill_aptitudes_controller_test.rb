require 'test_helper'

class SkillAptitudesControllerTest < ActionController::TestCase
  setup do
    @skill_aptitude = skill_aptitudes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skill_aptitudes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skill_aptitude" do
    assert_difference('SkillAptitude.count') do
      post :create, skill_aptitude: {  }
    end

    assert_redirected_to skill_aptitude_path(assigns(:skill_aptitude))
  end

  test "should show skill_aptitude" do
    get :show, id: @skill_aptitude
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skill_aptitude
    assert_response :success
  end

  test "should update skill_aptitude" do
    put :update, id: @skill_aptitude, skill_aptitude: {  }
    assert_redirected_to skill_aptitude_path(assigns(:skill_aptitude))
  end

  test "should destroy skill_aptitude" do
    assert_difference('SkillAptitude.count', -1) do
      delete :destroy, id: @skill_aptitude
    end

    assert_redirected_to skill_aptitudes_path
  end
end
