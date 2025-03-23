require "test_helper"

class Api::V1::TemplateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_template_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_template_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_template_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_template_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_template_destroy_url
    assert_response :success
  end
end
