require 'rails_helper'

RSpec.describe "Web::Enterprises", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/enterprise/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about_us" do
    it "returns http success" do
      get "/web/enterprise/about_us"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /why_maileraction" do
    it "returns http success" do
      get "/web/enterprise/why_maileraction"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /values" do
    it "returns http success" do
      get "/web/enterprise/values"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /partners" do
    it "returns http success" do
      get "/web/enterprise/partners"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /gdpr_compliance" do
    it "returns http success" do
      get "/web/enterprise/gdpr_compliance"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /corporate_responsibility" do
    it "returns http success" do
      get "/web/enterprise/corporate_responsibility"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact_us" do
    it "returns http success" do
      get "/web/enterprise/contact_us"
      expect(response).to have_http_status(:success)
    end
  end

end
