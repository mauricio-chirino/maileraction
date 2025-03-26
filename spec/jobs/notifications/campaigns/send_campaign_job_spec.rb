require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe Campaigns::SendCampaignJob, type: :job do
  describe "#perform" do
    before do
      ActiveJob::Base.queue_adapter = :test
    end

    let(:user) { create(:user, email_address: "testuser@mail.com") }
    let(:industry) { create(:industry) }
    let!(:email_record) { create(:email_record, industry: industry) }
    let(:campaign) do
      create(:campaign,
        user: user,
        industry: industry,
        subject: "Campaña de Prueba",
        body: "<h1>Hola</h1>",
        email_limit: 1
      )
    end




    it "dispara SendEmailJob con la notificación recién creada" do
      allow(Notifications::SendEmailJob).to receive(:perform_later)

      described_class.perform_now(campaign.id)

      notification = Notification.last
      expect(Notifications::SendEmailJob).to have_received(:perform_later).with(notification.id)
    end






    it "crea una notificación al completar la campaña" do
      expect {
        described_class.perform_now(campaign.id)
      }.to change(Notification, :count).by(1)

      expect(campaign.reload.status).to eq("completed")

      notification = Notification.last
      expect(notification.title).to include("Tu campaña fue enviada con éxito")
      expect(notification.body).to include("Campaña de Prueba")

      # ✅ Verificar pluralización dinámica
      count = campaign.email_limit
      word = count == 1 ? "destinatario" : "destinatarios"
      expect(notification.body).to include("#{count} #{word}")

      expect(notification.user).to eq(user)
    end




    it "dispara AdminNotifierJob si hay más de 3 errores recientes" do
      # Creamos una campaña válida
      campaign = create(:campaign, user: user, industry: industry, email_limit: 3, subject: "Error test", body: "Contenido")

      # Asociamos registros de email a la campaña
      email_records = create_list(:email_record, 3, industry: industry)
      email_records.each do |record|
        CampaignEmail.create!(campaign: campaign, email_record: record)
      end

      # Creamos 3 logs de error asociados a esa campaña
      create_list(:email_log, 3, status: "error", campaign: campaign, created_at: 3.minutes.ago)

      # Espiamos la ejecución real del job
      allow(AdminNotifierJob).to receive(:perform_later)

      # Ejecutamos el job
      described_class.perform_now(campaign.id)

      # Verificamos que se haya llamado AdminNotifierJob
      expect(AdminNotifierJob).to have_received(:perform_later).with("🚨 Se detectaron múltiples errores en el envío de campañas.")
    end



    it "NO dispara AdminNotifierJob si hay menos de 3 errores recientes" do
      EmailLog.delete_all

      allow(AdminNotifierJob).to receive(:perform_later)
      FactoryBot.create_list(:email_record, 2, industry: industry)

      campaign_with_errors = create(:campaign,
        user: user,
        industry: industry,
        subject: "Menos de 3 errores",
        body: "<p>Error test</p>",
        email_limit: 2
      )

      FactoryBot.create_list(:email_log, 2, status: "error", campaign: campaign_with_errors, created_at: 3.minutes.ago)

      healthy_campaign = create(:campaign,
        user: user,
        industry: industry,
        subject: "Otra campaña",
        body: "<p>Normal</p>",
        email_limit: 1
      )

      allow(AdminNotifierJob).to receive(:perform_later)

      described_class.perform_now(healthy_campaign.id)

      expect(AdminNotifierJob).not_to have_received(:perform_later)
    end




    it "NO dispara AdminNotifierJob si hay menos de 3 errores recientes (sin errores previos globales)" do
      EmailLog.delete_all

      allow(AdminNotifierJob).to receive(:perform_later)
      records = FactoryBot.create_list(:email_record, 2, industry: industry)

      campaign_with_errors = create(:campaign,
        user: user,
        industry: industry,
        subject: "Errores menores",
        body: "<p>Error test</p>",
        email_limit: 2
      )

      records.each do |record|
        CampaignEmail.create!(campaign: campaign_with_errors, email_record: record)
      end

      create_list(:email_log, 2, status: "error", campaign: campaign_with_errors, created_at: 3.minutes.ago)

      healthy_campaign = create(:campaign,
        user: user,
        industry: industry,
        subject: "Campaña normal",
        body: "<p>Todo bien</p>",
        email_limit: 1
      )

      described_class.perform_now(healthy_campaign.id)

      expect(AdminNotifierJob).not_to have_received(:perform_later)
    end



    it "incluye métricas cuando la campaña tiene éxitos y errores" do
      campaign = create(:campaign, user: user, industry: industry, email_limit: 6, subject: "Campaña de Prueba", body: "Contenido")

      email_records = create_list(:email_record, 6, industry: industry)
      email_records.each do |record|
        CampaignEmail.create!(campaign: campaign, email_record: record)
      end

      # 3 logs exitosos
      create_list(:email_log, 3, status: "success", campaign: campaign, created_at: 3.minutes.ago)

      # 3 logs con error
      create_list(:email_log, 3, status: "error", campaign: campaign, created_at: 3.minutes.ago)

      # Forzamos la ejecución del job
      described_class.perform_now(campaign.id)

      notification = Notification.last

      # Dinámicamente sacamos los datos reales
      total = campaign.email_limit
      success = EmailLog.where(campaign: campaign, status: "success").count
      errors = EmailLog.where(campaign: campaign, status: "error").count
      total_logs = success + errors
      error_rate = (errors.to_f / total_logs) * 100


      # Afirmamos que se refleje en la notificación
      expect(notification.body).to include("✅ Éxito: #{success}")
      expect(notification.body).to include("❌ Errores: #{errors}")
      expect(notification.body).to include("⚠️ Tasa de error: #{error_rate.round(1)}%")
    end




    it "crea una notificación genérica si no hay logs de envío" do
      EmailLog.delete_all
      EmailRecord.delete_all
      campaign = create(:campaign,
        user: user,
        industry: industry,
        subject: "Sin intentos",
        body: "<p>Nada se intentó</p>",
        email_limit: 1 # fuerza que no se intente enviar nada
      )

      # Forzar que no se envíe nada: sin asociar emails, sin logs
      EmailRecord.where(industry: campaign.industry).delete_all

      described_class.perform_now(campaign.id)

      notification = Notification.last
      expect(notification.title).to eq("⚠️ Campaña procesada sin envíos")
      expect(notification.body).to include("no se registraron intentos de envío")
    end
  end
end
