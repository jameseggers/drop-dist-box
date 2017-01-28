require 'test_helper'

class App::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_user = app_users(:one)
  end

  test "should get index" do
    get app_users_url
    assert_response :success
  end

  test "should get new" do
    get new_app_user_url
    assert_response :success
  end

  test "should create app_user" do
    assert_difference('App::User.count') do
      post app_users_url, params: { app_user: { email: @app_user.email, password: @app_user.password, password_confirmation: @app_user.password_confirmation } }
    end

    assert_redirected_to app_user_url(App::User.last)
  end

  test "should show app_user" do
    get app_user_url(@app_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_app_user_url(@app_user)
    assert_response :success
  end

  test "should update app_user" do
    patch app_user_url(@app_user), params: { app_user: { email: @app_user.email, password: @app_user.password, password_confirmation: @app_user.password_confirmation } }
    assert_redirected_to app_user_url(@app_user)
  end

  test "should destroy app_user" do
    assert_difference('App::User.count', -1) do
      delete app_user_url(@app_user)
    end

    assert_redirected_to app_users_url
  end
end
