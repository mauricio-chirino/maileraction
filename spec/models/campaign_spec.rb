require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "validations" do
    let(:user) { create(:user) }
    let(:industry) { create(:industry) }

    it "es inválida si no hay destinatarios disponibles" do
      campaign = Campaign.new(
        user: user,
        industry: industry,
        email_limit: 10,
        subject: "Test",
        body: "Contenido",
        status: "pending"
      )

      expect(campaign).not_to be_valid
      expect(campaign.errors[:base]).to include("La campaña no tiene destinatarios.")
    end

    it "es válida si no tiene body pero tiene un template con contenido" do
      user = create(:user)
      industry = create(:industry)
      template = Template.create!(
        name: "Plantilla bienvenida",
        content: "<h1>¡Hola!</h1>",
        public: false,
        user: user
      )
      create_list(:email_record, 5, industry: industry)

      campaign = Campaign.new(
        user: user,
        industry: industry,
        email_limit: 5,
        subject: "Con plantilla",
        body: nil,
        template: template,
        status: "pending"
      )

      # Simulamos la lógica del job que toma el template.content si no hay body
      email_body = campaign.body.presence || campaign.template&.content

      expect(email_body).to eq("<h1>¡Hola!</h1>")
      expect(campaign).to be_valid
    end

    it "es inválida si no tiene body ni template" do
      campaign = Campaign.new(
        user: user,
        industry: industry,
        email_limit: 5,
        subject: "Campaña vacía",
        body: nil,
        template: nil,
        status: "pending"
      )

      expect(campaign).not_to be_valid
      expect(campaign.errors[:body]).to include("no puede estar vacío si no se selecciona una plantilla con contenido.")
    end
  end
end
