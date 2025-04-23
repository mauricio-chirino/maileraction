require 'rails_helper'

RSpec.describe "Web::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/product/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /email_marketing" do
    it "returns http success" do
      get "/web/product/email_marketing"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /automate" do
    it "returns http success" do
      get "/web/product/automate"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /websites" do
    it "returns http success" do
      get "/web/product/websites"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /transactional_email" do
    it "returns http success" do
      get "/web/product/transactional_email"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /integrations" do
    it "returns http success" do
      get "/web/product/integrations"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /compare_mailer_action" do
    it "returns http success" do
      get "/web/product/compare_mailer_action"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /developer_api" do
    it "returns http success" do
      get "/web/product/developer_api"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /news" do
    it "returns http success" do
      get "/web/product/news"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /templates" do
    it "returns http success" do
      get "/web/product/templates"
      expect(response).to have_http_status(:success)
    end
  end

end
