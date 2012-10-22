require 'test_helper'

class MissionEmbeddingsControllerTest < ActionController::TestCase
  setup do
    @mission_embedding = mission_embeddings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mission_embeddings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mission_embedding" do
    assert_difference('MissionEmbedding.count') do
      post :create, mission_embedding: {  }
    end

    assert_redirected_to mission_embedding_path(assigns(:mission_embedding))
  end

  test "should show mission_embedding" do
    get :show, id: @mission_embedding
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mission_embedding
    assert_response :success
  end

  test "should update mission_embedding" do
    put :update, id: @mission_embedding, mission_embedding: {  }
    assert_redirected_to mission_embedding_path(assigns(:mission_embedding))
  end

  test "should destroy mission_embedding" do
    assert_difference('MissionEmbedding.count', -1) do
      delete :destroy, id: @mission_embedding
    end

    assert_redirected_to mission_embeddings_path
  end
end
