require 'test_helper'

class SfvsControllerTest < ActionController::TestCase
  setup do
    @sfv = sfvs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sfvs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sfv" do
    assert_difference('Sfv.count') do
      post :create, sfv: { data: @sfv.data, id: @sfv.id }
    end

    assert_redirected_to sfv_path(assigns(:sfv))
  end

  test "should show sfv" do
    get :show, id: @sfv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sfv
    assert_response :success
  end

  test "should update sfv" do
    patch :update, id: @sfv, sfv: { data: @sfv.data, id: @sfv.id }
    assert_redirected_to sfv_path(assigns(:sfv))
  end

  test "should destroy sfv" do
    assert_difference('Sfv.count', -1) do
      delete :destroy, id: @sfv
    end

    assert_redirected_to sfvs_path
  end
end
