require 'test_helper'

class BuddyWalksControllerTest < ActionController::TestCase
  setup do
    @buddy_walk = buddy_walks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buddy_walks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buddy_walk" do
    assert_difference('BuddyWalk.count') do
      post :create, buddy_walk: { description: @buddy_walk.description, place: @buddy_walk.place, title: @buddy_walk.title }
    end

    assert_redirected_to buddy_walk_path(assigns(:buddy_walk))
  end

  test "should show buddy_walk" do
    get :show, id: @buddy_walk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buddy_walk
    assert_response :success
  end

  test "should update buddy_walk" do
    patch :update, id: @buddy_walk, buddy_walk: { description: @buddy_walk.description, place: @buddy_walk.place, title: @buddy_walk.title }
    assert_redirected_to buddy_walk_path(assigns(:buddy_walk))
  end

  test "should destroy buddy_walk" do
    assert_difference('BuddyWalk.count', -1) do
      delete :destroy, id: @buddy_walk
    end

    assert_redirected_to buddy_walks_path
  end
end
