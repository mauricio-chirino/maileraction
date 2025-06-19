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
# user = User.first # O el usuario que corresponda

# template = Template.create!(
#   name: "Promoción Primavera",
#   description: "Una plantilla fresca para promociones de temporada...",
#   category: "Business",
#   user_id: user.id,
#   public: true,
#   preview_image_url: "https://mi-cdn.com/templates/spring-promo.png",
#   html_content: "<html>...tu código de plantilla aquí...</html>"
# )

# template.template_blocks.create!(
#   block_type: "hero",
#   html_content: "<div class='hero'>¡Bienvenida Primavera!</div>",
#   position: 1
# )

# template.template_blocks.create!(
#   block_type: "content",
#   html_content: "<div class='content'>Oferta especial solo por esta semana...</div>",
#   position: 2
# )



# db/seeds.rb

user = User.first

templates_seed = [
  {
    name: "Carrito abandonado",
    description: "Recupera ventas pendientes con un recordatorio visual.",
    category: "Marketing & Promociones",
    theme: "Carrito abandonado",
    html_content: <<~HTML,
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#fff;border-radius:8px;font-family:sans-serif;">
        <tr>
          <td align="center" style="padding:40px 0 20px;">
            <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=200&q=80" width="80" alt="Carrito" style="border-radius:50%;">
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:0 30px 10px;">
            <h1 style="font-size:28px;color:#252525;margin:0;">¡No olvides tus compras!</h1>
            <p style="font-size:16px;color:#666;margin:12px 0 0;">Tienes productos en tu carrito esperando por ti.<br>Completa tu compra y obtén un <strong>10% de descuento</strong>.</p>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:20px;">
            <a href="#" style="background:#35c27f;color:#fff;padding:14px 32px;border-radius:24px;text-decoration:none;font-weight:bold;font-size:16px;">Ir al carrito</a>
          </td>
        </tr>
      </table>
    HTML
    preview_image_url: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80"
  },
  {
    name: "Promoción de verano",
    description: "Oferta especial de verano para tus clientes.",
    category: "Festividades & Estaciones",
    theme: "Verano",
    html_content: <<~HTML,
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#e8f6ff;border-radius:8px;font-family:sans-serif;">
        <tr>
          <td align="center" style="padding:30px 0 10px;">
            <img src="https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=200&q=80" width="90" alt="Summer" style="border-radius:12px;">
          </td>
        </tr>
        <tr>
          <td align="center">
            <h1 style="font-size:26px;color:#0c69b6;margin:0;">¡Llegó el verano!</h1>
            <h3 style="font-size:18px;color:#1574b6;margin:12px 0 8px;">Descuentos imperdibles</h3>
            <p style="font-size:15px;color:#444;margin:0;">Disfruta de hasta <strong>30% off</strong> en productos seleccionados.</p>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:18px;">
            <a href="#" style="background:#ffb200;color:#fff;padding:14px 28px;border-radius:24px;text-decoration:none;font-weight:bold;font-size:16px;">Ver ofertas</a>
          </td>
        </tr>
      </table>
    HTML
    preview_image_url: "https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80"
  },
  {
    name: "Bienvenida a nuevos clientes",
    description: "Da la mejor primera impresión a tus nuevos suscriptores.",
    category: "Negocios & Newsletter",
    theme: "Bienvenida",
    html_content: <<~HTML,
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#f4f4fb;border-radius:8px;font-family:sans-serif;">
        <tr>
          <td align="center" style="padding:35px 0 5px;">
            <img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=200&q=80" width="70" alt="Bienvenida" style="border-radius:50%;">
          </td>
        </tr>
        <tr>
          <td align="center">
            <h1 style="font-size:27px;color:#3f3a5f;margin:0;">¡Bienvenido/a!</h1>
            <p style="font-size:16px;color:#67617a;margin:16px 0 0;">
              Gracias por unirte a nuestra comunidad.<br>
              Esperamos que disfrutes de todos los beneficios.<br>
              <span style="display:inline-block;margin-top:8px;">😊</span>
            </p>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:18px;">
            <a href="#" style="background:#3f3a5f;color:#fff;padding:12px 28px;border-radius:24px;text-decoration:none;font-weight:bold;font-size:16px;">Descubre más</a>
          </td>
        </tr>
      </table>
    HTML
    preview_image_url: "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=400&q=80"
  },
  {
    name: "Recetas para compartir",
    description: "Comparte recetas deliciosas con tus suscriptores.",
    category: "Restaurantes y Alimentos",
    theme: "Recetas",
    html_content: <<~HTML,
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#fff8ee;border-radius:8px;font-family:sans-serif;">
        <tr>
          <td align="center" style="padding:28px 0 10px;">
            <img src="https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=200&q=80" width="80" alt="Recetas" style="border-radius:10px;">
          </td>
        </tr>
        <tr>
          <td align="center">
            <h1 style="font-size:26px;color:#a67c52;margin:0;">Receta del Día</h1>
            <h3 style="font-size:18px;color:#7e6147;margin:10px 0 6px;">¡Prueba esta delicia!</h3>
            <p style="font-size:15px;color:#666;margin:0;">Descubre el paso a paso para preparar un platillo espectacular en casa.</p>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:18px;">
            <a href="#" style="background:#fd9340;color:#fff;padding:12px 28px;border-radius:24px;text-decoration:none;font-weight:bold;font-size:16px;">Ver receta</a>
          </td>
        </tr>
      </table>
    HTML
    preview_image_url: "https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80"
  },
  {
    name: "Invitación a evento especial",
    description: "Invita a tus clientes a un evento memorable.",
    category: "Eventos & Invitaciones",
    theme: "Invitación a eventos",
    html_content: <<~HTML,
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#f5fafd;border-radius:8px;font-family:sans-serif;">
        <tr>
          <td align="center" style="padding:32px 0 6px;">
            <img src="https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=200&q=80" width="80" alt="Evento" style="border-radius:14px;">
          </td>
        </tr>
        <tr>
          <td align="center">
            <h1 style="font-size:27px;color:#326698;margin:0;">¡Estás invitado!</h1>
            <p style="font-size:15px;color:#5e7fa3;margin:15px 0 0;">Acompáñanos a un evento único.<br>Reserva tu lugar y vive la experiencia.</p>
          </td>
        </tr>
        <tr>
          <td align="center" style="padding:16px;">
            <a href="#" style="background:#326698;color:#fff;padding:12px 28px;border-radius:24px;text-decoration:none;font-weight:bold;font-size:16px;">Confirmar asistencia</a>
          </td>
        </tr>
      </table>
    HTML
    preview_image_url: "https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80"
  }
]

templates_seed.each do |attrs|
  Template.create!(
    attrs.merge(
      user: user,
      public: true
    )
  )
end

puts "Plantillas con HTML complejo creadas."
