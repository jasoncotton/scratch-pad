require 'test_helper'

class ReleasesControllerTest < ActionController::TestCase
  setup do
    @release = releases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:releases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create release" do
    assert_difference('Release.count') do
      post :create, release: { added: @release.added, category_id: @release.category_id, episode_id: @release.episode_id, grabs: @release.grabs, group_id: @release.group_id, id: @release.id, movie_id: @release.movie_id, movie_metablack_id: @release.movie_metablack_id, name: @release.name, nfo_id: @release.nfo_id, nfo_metablack_id: @release.nfo_metablack_id, nzb_id: @release.nzb_id, passworded: @release.passworded, posted: @release.posted, posted_by: @release.posted_by, rar_metablack_id: @release.rar_metablack_id, regex_id: @release.regex_id, search_name: @release.search_name, sfv_id: @release.sfv_id, sfv_metablack_id: @release.sfv_metablack_id, size: @release.size, status: @release.status, tvshow_id: @release.tvshow_id, tvshow_metablack_id: @release.tvshow_metablack_id, unwanted: @release.unwanted }
    end

    assert_redirected_to release_path(assigns(:release))
  end

  test "should show release" do
    get :show, id: @release
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @release
    assert_response :success
  end

  test "should update release" do
    patch :update, id: @release, release: { added: @release.added, category_id: @release.category_id, episode_id: @release.episode_id, grabs: @release.grabs, group_id: @release.group_id, id: @release.id, movie_id: @release.movie_id, movie_metablack_id: @release.movie_metablack_id, name: @release.name, nfo_id: @release.nfo_id, nfo_metablack_id: @release.nfo_metablack_id, nzb_id: @release.nzb_id, passworded: @release.passworded, posted: @release.posted, posted_by: @release.posted_by, rar_metablack_id: @release.rar_metablack_id, regex_id: @release.regex_id, search_name: @release.search_name, sfv_id: @release.sfv_id, sfv_metablack_id: @release.sfv_metablack_id, size: @release.size, status: @release.status, tvshow_id: @release.tvshow_id, tvshow_metablack_id: @release.tvshow_metablack_id, unwanted: @release.unwanted }
    assert_redirected_to release_path(assigns(:release))
  end

  test "should destroy release" do
    assert_difference('Release.count', -1) do
      delete :destroy, id: @release
    end

    assert_redirected_to releases_path
  end
end
