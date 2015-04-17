require 'test_helper'

class NzbsControllerTest < ActionController::TestCase
  setup do
    @nzb = nzbs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nzbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nzb" do
    assert_difference('Nzb.count') do
      post :create, nzb: { data: @nzb.data, id: @nzb.id }
    end

    assert_redirected_to nzb_path(assigns(:nzb))
  end

  test "should show nzb" do
    get :show, id: @nzb
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nzb
    assert_response :success
  end

  test "should update nzb" do
    patch :update, id: @nzb, nzb: { data: @nzb.data, id: @nzb.id }
    assert_redirected_to nzb_path(assigns(:nzb))
  end

  test "should destroy nzb" do
    assert_difference('Nzb.count', -1) do
      delete :destroy, id: @nzb
    end

    assert_redirected_to nzbs_path
  end
end
