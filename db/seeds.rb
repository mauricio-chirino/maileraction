# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
#


# puts "🚀 Ejecutando seed seguro (sin duplicados)..."

# # ---------------------------
# # Industrias simuladas
# # ---------------------------
# puts "🏭 Sembrando industrias..."

# industrias = [
#   "Administración de edificios", "Agencias de publicidad", "Clínicas dentales",
#   "Consultorías TI", "Contabilidad", "Educación superior", "Escuelas de idiomas",
#   "Farmacias", "Gimnasios", "Hoteles", "Ingeniería industrial", "Inmobiliarias",
#   "Jardines infantiles", "Logística y transporte", "Marketing digital",
#   "Notarías", "Odontología estética", "Psicología clínica", "Seguridad privada",
#   "Veterinarias"
# ]

# industrias.each do |nombre|
#   Industry.find_or_create_by!(name: nombre) do |industry|
#     industry.email_count = rand(1000..5000)
#   end
# end
# puts "✅ Industrias listas: #{Industry.count}"

# # ---------------------------
# # Planes
# # ---------------------------
# puts "📦 Sembrando planes..."

# [
#   { name: "Basic", max: 1, campaigna: 1, max_email: 3000 },
#   { name: "Pro", max: 3, campaigna: 5, max_email: 10000 },
#   { name: "Premium", max: 10, campaigna: 20, max_email: 50000 }
# ].each do |plan_data|
#   Plan.find_or_create_by!(name: plan_data[:name]) do |plan|
#     plan.max = plan_data[:max]
#     plan.campaigna = plan_data[:campaigna]
#     plan.max_email = plan_data[:max_email]
#   end
# end
# puts "✅ Planes creados: #{Plan.count}"

# # ---------------------------
# # Usuario administrador
# # ---------------------------
# puts "🧑‍💼 Creando usuario administrador..."

# admin = User.find_or_initialize_by(email: "admin@mail.com")
# admin.password = "password"
# admin.role = :admin
# admin.plan = Plan.find_by(name: "Premium")
# admin.save!
# puts "✅ Usuario admin creado: #{admin.email}"

# # ---------------------------
# # Créditos iniciales
# # ---------------------------
# puts "💰 Asociando cuenta de crédito..."

# CreditAccount.find_or_create_by!(user: admin) do |account|
#   account.available_credit = 1000
# end
# puts "✅ Créditos disponibles para admin: #{admin.credit_account.available_credit}"



puts "Sembrando campañas de prueba..."

admin = User.find_by(email: "admin@mail.com")

unless admin
  puts "Usuario admin no encontrado. Asegúrate de ejecutar primero los seeds básicos."
  return
end

industry = Industry.first || Industry.create!(name: "Tecnología", email_count: 1000)

3.times do |i|
  Campaign.find_or_create_by!(user: admin, industry: industry) do |campaign|
    campaign.status = "pending"
    campaign.created_at = Time.now - (i + 1).days
    campaign.email_limit = 500
  end
end

puts "✅ Campañas creadas: #{admin.campaigns.count}"




puts "Generando emails simulados..."

email_records = []

10.times do |i|
  email_records << EmailRecord.find_or_create_by!(
    email: "test#{i}@example.com",
    company: "Empresa #{i}",
    website: "https://empresa#{i}.cl",
    industry: industry
  )
end

puts "✅ Emails simulados: #{email_records.count}"




puts "Asociando emails a campañas..."

admin.campaigns.each do |campaign|
  email_records.each do |record|
    CampaignEmail.find_or_create_by!(campaign_id: campaign.id, email_record_id: record.id)
  end
end

puts "✅ Emails asociados a campañas"




puts "Generando estadísticas ficticias..."

admin.campaigns.each do |campaign|
  email_records.each_with_index do |record, i|
    EmailLog.find_or_create_by!(campaign_id: campaign.id, email_record_id: record.id) do |log|
      log.status = "delivered"
      log.opened_at = i.even? ? Time.now - rand(10).minutes : nil
      log.clicked_at = i % 3 == 0 ? Time.now - rand(5).minutes : nil
    end

    if i % 4 == 0 # 25% de rebote simulado
      Bounce.find_or_create_by!(email_record_id: record.id) do |bounce|
        bounce.reason = "Dirección no válida"
        bounce.bounced_at = Time.now
      end
    end
  end
end

puts "✅ Estadísticas creadas"
