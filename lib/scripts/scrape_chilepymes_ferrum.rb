require "ferrum"
require "nokogiri"

puts "🚀 Iniciando navegador headless con Ferrum..."

browser = Ferrum::Browser.new(
  headless: true,
  browser_path: "/usr/bin/chromium", # Asegurate que esta ruta exista
  window_size: [ 1280, 800 ],
  timeout: 20
)

begin
  browser.goto("https://chilepymes.com/empresas/")
  puts "🌐 Cargando página..."
  browser.goto("https://chilepymes.com/empresas/")

  # Esperar explícitamente al selector
  browser.wait_for_selector(".empresa-list-item", timeout: 10)

  puts "✅ Página cargada correctamente."

html = browser.body
puts "📄 HTML renderizado (primeros 500 chars):"
puts html[0..500]


  doc = Nokogiri::HTML(html)
  empresas = doc.css(".empresa-list-item")
  puts "🔎 Empresas detectadas: #{empresas.count}"

  empresas.each do |company_node|
    company_name = company_node.at_css(".empresa-nombre")&.text&.strip
    address      = company_node.at_css(".empresa-direccion")&.text&.strip
    region       = company_node.at_css(".empresa-region")&.text&.strip
    description  = company_node.at_css(".empresa-descripcion")&.text&.strip
    email        = company_node.at_css("a[href^='mailto:']")&.[]("href")&.gsub("mailto:", "")
    website      = company_node.at_css("a[href^='http']")&.[]("href") || "https://chilepymes.com"

    next if email.blank?

    puts "✅ #{email} | #{company_name}"

    PublicEmailRecord.find_or_create_by(email: email) do |record|
      record.company_name = company_name
      record.website      = website
      record.address      = address
      record.city         = region
      record.municipality = nil
      record.country      = "Chile"
      record.description  = description
      record.industry     = nil # Luego implementamos clasificación
    end
  end

rescue => e
  puts "❌ Error durante el scraping: #{e.message}"
  puts e.backtrace.first(10)
ensure
  browser.quit
end
