require "test_helper"

class Api::V1::WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should get payment" do
    get api_v1_webhooks_payment_url
    assert_response :success
  end
end
