require 'rails_helper'

describe "GET /api/v1/public_email_records/search", type: :request do
  let(:user) { create(:user) }
  let!(:industry) { create(:industry, name: "Veterinarias") }
  let!(:record_verified) { create(:public_email_record, industry: industry, status: :verified) }
  let!(:record_unverified) { create(:public_email_record, industry: industry, status: :unverified) }
  let!(:other_industry) { create(:industry, name: "Logística") }
  let!(:record_other) { create(:public_email_record, industry: other_industry, status: :verified) }

  before { sign_in user }

  it "devuelve solo registros del rubro solicitado" do
    get "/api/v1/public_email_records/search", params: { industry: "Veterinarias" }
    expect(response).to have_http_status(:ok)
    expect(json.size).to eq(2)
    expect(json.map { |r| r["industry_id"] }).to all(eq(industry.id))
  end

  it "devuelve error si el rubro no existe" do
    get "/api/v1/public_email_records/search", params: { industry: "Inexistente" }
    expect(response).to have_http_status(:not_found)
    expect(json["error"]).to eq("Industria no encontrada")
  end

  def json
    JSON.parse(response.body)
  end
end
