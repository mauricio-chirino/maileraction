require 'rails_helper'

RSpec.describe "Web::Communities", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/community/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /user_forum" do
    it "returns http success" do
      get "/web/community/user_forum"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /referral_program" do
    it "returns http success" do
      get "/web/community/referral_program"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /developer_community" do
    it "returns http success" do
      get "/web/community/developer_community"
      expect(response).to have_http_status(:success)
    end
  end

end
