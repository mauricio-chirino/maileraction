require 'rails_helper'

RSpec.describe "Web::Resources", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/web/resources/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /blog" do
    it "returns http success" do
      get "/web/resources/blog"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /success_stories" do
    it "returns http success" do
      get "/web/resources/success_stories"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /webinars_and_events" do
    it "returns http success" do
      get "/web/resources/webinars_and_events"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /guides_and_tutorials" do
    it "returns http success" do
      get "/web/resources/guides_and_tutorials"
      expect(response).to have_http_status(:success)
    end
  end

end
