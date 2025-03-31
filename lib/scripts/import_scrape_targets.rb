# Este script se utiliza para importar URLs desde un archivo de texto
# y crear registros en la base de datos para el scraping de correos electrónicos.
# El archivo de texto debe contener una URL por línea.
#
# Se ejecuta con : bin/rails runner lib/scripts/import_scrape_targets.rb
#
# lib/scripts/import_scrape_targets.rb
urls = File.readlines(Rails.root.join("lib", "data", "urls.txt")).map(&:strip)

urls.each do |url|
  ScrapeTarget.find_or_create_by(url: url) do |t|
    t.status = "pending"
  end
end
