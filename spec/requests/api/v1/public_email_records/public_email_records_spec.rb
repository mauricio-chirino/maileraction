# spec/requests/api/v1/public_email_records_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::PublicEmailRecords", type: :request do
  let(:user) { create(:user) }
  let(:industry) { create(:industry, name: "Veterinarias") }
  let!(:record) { create(:public_email_record, industry: industry, status: :verified) }

  describe "GET /api/v1/public_email_records" do
    context "cuando el usuario está autenticado" do
      before do
        sign_in user
        get "/api/v1/public_email_records"
      end

      it "responde con éxito" do
        expect(response).to have_http_status(:ok)
      end

      it "retorna registros de correo" do
        json = JSON.parse(response.body)
        expect(json["public_email_records"]).not_to be_empty
      end
    end

    context "cuando el usuario no está autenticado" do
      it "retorna 401 Unauthorized" do
        get "/api/v1/public_email_records"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /api/v1/public_email_records?industry_id=ID" do
    before do
      sign_in user
      get "/api/v1/public_email_records", params: { industry_id: industry.id }
    end

    it "filtra por industria" do
      json = JSON.parse(response.body)
      expect(json["public_email_records"]).not_to be_empty
    end
  end
end
