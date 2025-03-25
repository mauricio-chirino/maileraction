require 'rails_helper'


RSpec.describe "SupportRequests", type: :request do
  let(:user) { create(:user, password: "password123") }

  before do
    post "/login", params: {
      email_address: user.email_address,
      password: "password123"
    }
  end

  describe "POST /api/v1/support_requests" do
    it "crea una solicitud de soporte válida" do
      post "/api/v1/support_requests", params: {
        support_request: {
          message: "Encontré un bug al crear una campaña.",
          category: "bug"
        }
      }

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)
      expect(json["message"]).to eq("Encontré un bug al crear una campaña.")
      expect(json["status"]).to eq("open")
    end

    context "cuando el usuario no está autenticado" do
      it "retorna 401 Unauthorized" do
        delete "/logout" # Destruye la sesión actual

        post "/api/v1/support_requests", params: {
          support_request: {
            message: "Intento sin login",
            category: "idea"
          }
        }

        expect(response).to have_http_status(:unauthorized).or have_http_status(:forbidden)

        json = JSON.parse(response.body) rescue {}
        expect(json["errors"] || json["error"]).to be_present
      end
    end
  end
end
