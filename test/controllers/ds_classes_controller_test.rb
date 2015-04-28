require 'test_helper'

class DsClassesControllerTest < ActionController::TestCase
  setup do
    @ds_class = ds_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ds_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ds_class" do
    assert_difference('DsClass.count') do
      post :create, ds_class: { description: @ds_class.description, end_date: @ds_class.end_date, end_time: @ds_class.end_time, place: @ds_class.place, start_date: @ds_class.start_date, start_time: @ds_class.start_time, title: @ds_class.title }
    end

    assert_redirected_to ds_class_path(assigns(:ds_class))
  end

  test "should show ds_class" do
    get :show, id: @ds_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ds_class
    assert_response :success
  end

  test "should update ds_class" do
    patch :update, id: @ds_class, ds_class: { description: @ds_class.description, end_date: @ds_class.end_date, end_time: @ds_class.end_time, place: @ds_class.place, start_date: @ds_class.start_date, start_time: @ds_class.start_time, title: @ds_class.title }
    assert_redirected_to ds_class_path(assigns(:ds_class))
  end

  test "should destroy ds_class" do
    assert_difference('DsClass.count', -1) do
      delete :destroy, id: @ds_class
    end

    assert_redirected_to ds_classes_path
  end
end
