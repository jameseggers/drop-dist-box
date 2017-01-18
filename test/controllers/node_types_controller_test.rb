require 'test_helper'

class NodeTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @node_type = node_types(:one)
  end

  test "should get index" do
    get node_types_url
    assert_response :success
  end

  test "should get new" do
    get new_node_type_url
    assert_response :success
  end

  test "should create node_type" do
    assert_difference('NodeType.count') do
      post node_types_url, params: { node_type: { name: @node_type.name } }
    end

    assert_redirected_to node_type_url(NodeType.last)
  end

  test "should show node_type" do
    get node_type_url(@node_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_node_type_url(@node_type)
    assert_response :success
  end

  test "should update node_type" do
    patch node_type_url(@node_type), params: { node_type: { name: @node_type.name } }
    assert_redirected_to node_type_url(@node_type)
  end

  test "should destroy node_type" do
    assert_difference('NodeType.count', -1) do
      delete node_type_url(@node_type)
    end

    assert_redirected_to node_types_url
  end
end
