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

puts "🚀 Ejecutando seed seguro (sin duplicados)..."

# 1. INDUSTRIAS
industries = [
  "Administración de Edificios", "Logística", "Marketing Digital", "Turismo", "Comercio Electrónico",
  "Contabilidad", "Desarrollo de Software", "Veterinarias", "Arquitectura", "Consultorías",
  "Servicios Financieros", "Odontología", "Restaurantes", "Constructoras", "Servicios Jurídicos",
  "Ingeniería Eléctrica", "Escuelas de Música", "Agencias de Viajes", "Empresas de Seguridad", "Farmacias"
]

industries.each do |name|
  industry = Industry.find_or_initialize_by(name: name)
  industry.email_count ||= rand(150..3000)
  industry.save!
end

puts "✅ Industrias listas: #{Industry.count}"

# 2. USUARIO DE PRUEBA
user = User.find_or_create_by!(email: "admin@mail.com") do |u|
  u.password = "password"
  u.role = :admin
end
puts "👤 Usuario de prueba: #{user.email}"

# 3. CAMPAÑAS DE PRUEBA
10.times do |i|
  # campaign_name = "SeedCampaign-#{i + 1}"
  Campaign.find_or_create_by!(user: user, email_limit: rand(500..2000), industry: Industry.order("RANDOM()").first) do |c|
    c.status = %w[draft scheduled sent].sample
  end
end
puts "📩 Campañas creadas: #{Campaign.count}"

# 4. EMAIL RECORDS (NO DUPLICADOS)
100.times do |i|
  email = "user#{i + 1}@empresa.com"
  EmailRecord.find_or_create_by!(email: email) do |record|
    record.company = "Empresa #{i + 1}"
    record.website = "https://empresa#{i + 1}.cl"
    record.industry = Industry.order("RANDOM()").first
  end
end
puts "📧 EmailRecords totales: #{EmailRecord.count}"

# 5. CAMPAIGN EMAILS (EVITANDO DUPLICADOS)
Campaign.all.each do |campaign|
  records = EmailRecord.order("RANDOM()").limit(5)
  records.each do |record|
    CampaignEmail.find_or_create_by!(campaign: campaign, email_record: record)
  end
end
puts "🔗 Relaciones Campaña-Email: #{CampaignEmail.count}"

puts "🎉 Seed ejecutado con éxito y sin duplicaciones."
