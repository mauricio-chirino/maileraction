require "test_helper"

class Api::V1::CreditAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_v1_credit_accounts_show_url
    assert_response :success
  end
end
