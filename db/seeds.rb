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




# crea los template
#
user = User.first # O el usuario que corresponda

template = Template.create!(
  name: "Promoción Primavera",
  description: "Una plantilla fresca para promociones de temporada...",
  category: "Business",
  user_id: user.id,
  public: true,
  preview_image_url: "https://mi-cdn.com/templates/spring-promo.png",
  html_content: "<html>...tu código de plantilla aquí...</html>"
)

template.template_blocks.create!(
  block_type: "hero",
  html_content: "<div class='hero'>¡Bienvenida Primavera!</div>",
  position: 1
)

template.template_blocks.create!(
  block_type: "content",
  html_content: "<div class='content'>Oferta especial solo por esta semana...</div>",
  position: 2
)
