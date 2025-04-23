require 'rails_helper'

RSpec.describe "Web::Legals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/legal/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /terms_of_service" do
    it "returns http success" do
      get "/web/legal/terms_of_service"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /privacy_policy" do
    it "returns http success" do
      get "/web/legal/privacy_policy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cookie_settings" do
    it "returns http success" do
      get "/web/legal/cookie_settings"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /security" do
    it "returns http success" do
      get "/web/legal/security"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /brand_assets" do
    it "returns http success" do
      get "/web/legal/brand_assets"
      expect(response).to have_http_status(:success)
    end
  end

end
