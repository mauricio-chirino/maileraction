require 'rails_helper'

RSpec.describe "Web::Supports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/support/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /customer_support" do
    it "returns http success" do
      get "/web/support/customer_support"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /migrate_to_maileraction" do
    it "returns http success" do
      get "/web/support/migrate_to_maileraction"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /report_spam" do
    it "returns http success" do
      get "/web/support/report_spam"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /tutorials" do
    it "returns http success" do
      get "/web/support/tutorials"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /deliverability_diagnostics" do
    it "returns http success" do
      get "/web/support/deliverability_diagnostics"
      expect(response).to have_http_status(:success)
    end
  end

end
