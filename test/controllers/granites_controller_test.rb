require 'test_helper'

class GranitesControllerTest < ActionController::TestCase
  setup do
    @granite = granites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:granites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create granite" do
    assert_difference('Granite.count') do
      post :create, granite: { image: @granite.image, name: @granite.name }
    end

    assert_redirected_to granite_path(assigns(:granite))
  end

  test "should show granite" do
    get :show, id: @granite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @granite
    assert_response :success
  end

  test "should update granite" do
    patch :update, id: @granite, granite: { image: @granite.image, name: @granite.name }
    assert_redirected_to granite_path(assigns(:granite))
  end

  test "should destroy granite" do
    assert_difference('Granite.count', -1) do
      delete :destroy, id: @granite
    end

    assert_redirected_to granites_path
  end
end
