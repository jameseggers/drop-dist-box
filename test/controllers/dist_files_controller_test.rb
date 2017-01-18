require 'test_helper'

class DistFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dist_file = dist_files(:one)
  end

  test "should get index" do
    get dist_files_url
    assert_response :success
  end

  test "should get new" do
    get new_dist_file_url
    assert_response :success
  end

  test "should create dist_file" do
    assert_difference('DistFile.count') do
      post dist_files_url, params: { dist_file: { internalName: @dist_file.internalName, name: @dist_file.name, user_id: @dist_file.user_id } }
    end

    assert_redirected_to dist_file_url(DistFile.last)
  end

  test "should show dist_file" do
    get dist_file_url(@dist_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_dist_file_url(@dist_file)
    assert_response :success
  end

  test "should update dist_file" do
    patch dist_file_url(@dist_file), params: { dist_file: { internalName: @dist_file.internalName, name: @dist_file.name, user_id: @dist_file.user_id } }
    assert_redirected_to dist_file_url(@dist_file)
  end

  test "should destroy dist_file" do
    assert_difference('DistFile.count', -1) do
      delete dist_file_url(@dist_file)
    end

    assert_redirected_to dist_files_url
  end
end
