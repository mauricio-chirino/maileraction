require "test_helper"

class Api::V1::StatsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_v1_stats_show_url
    assert_response :success
  end
end
