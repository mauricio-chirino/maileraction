require "test_helper"

class Api::V1::IndustriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_industries_index_url
    assert_response :success
  end
end
