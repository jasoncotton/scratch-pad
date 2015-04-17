require 'test_helper'

class NfosControllerTest < ActionController::TestCase
  setup do
    @nfo = nfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nfo" do
    assert_difference('Nfo.count') do
      post :create, nfo: { data: @nfo.data, id: @nfo.id }
    end

    assert_redirected_to nfo_path(assigns(:nfo))
  end

  test "should show nfo" do
    get :show, id: @nfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nfo
    assert_response :success
  end

  test "should update nfo" do
    patch :update, id: @nfo, nfo: { data: @nfo.data, id: @nfo.id }
    assert_redirected_to nfo_path(assigns(:nfo))
  end

  test "should destroy nfo" do
    assert_difference('Nfo.count', -1) do
      delete :destroy, id: @nfo
    end

    assert_redirected_to nfos_path
  end
end
