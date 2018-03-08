require 'test_helper'

class ExcursionsControllerTest < ActionController::TestCase
  setup do
    @excursion = excursions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:excursions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create excursion" do
    assert_difference('Excursion.count') do
      post :create, excursion: { banner: @excursion.banner, days: @excursion.days, destination_id: @excursion.destination_id, subtitle: @excursion.subtitle, title: @excursion.title, url: @excursion.url }
    end

    assert_redirected_to excursion_path(assigns(:excursion))
  end

  test "should show excursion" do
    get :show, id: @excursion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @excursion
    assert_response :success
  end

  test "should update excursion" do
    patch :update, id: @excursion, excursion: { banner: @excursion.banner, days: @excursion.days, destination_id: @excursion.destination_id, subtitle: @excursion.subtitle, title: @excursion.title, url: @excursion.url }
    assert_redirected_to excursion_path(assigns(:excursion))
  end

  test "should destroy excursion" do
    assert_difference('Excursion.count', -1) do
      delete :destroy, id: @excursion
    end

    assert_redirected_to excursions_path
  end
end
