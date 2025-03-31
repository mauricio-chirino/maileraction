require "httparty"
require "nokogiri"

class ChilePymesScraperService
  BASE_URL = "https://chilepymes.com/empresas/".freeze

  def initialize(page = 1)
    @page = page
  end

  def scrape
    url = "#{BASE_URL}?page=#{@page}"
    response = HTTParty.get(url)

    puts "📥 Respuesta: #{response.code} desde #{url}"
    puts "URL: #{url}"
    if response.success?
      parse_page(response.body)
    else
      puts "❌ Error al acceder al sitio (status: #{response.code})"
    end
  end

  private

  def parse_page(html)
    doc = Nokogiri::HTML(html)

    doc.css(".empresa-list-item").each do |company_node|
      company_name = company_node.at_css(".empresa-nombre")&.text&.strip
      address      = company_node.at_css(".empresa-direccion")&.text&.strip
      region       = company_node.at_css(".empresa-region")&.text&.strip
      description  = company_node.at_css(".empresa-descripcion")&.text&.strip
      email        = company_node.at_css("a[href^='mailto:']")&.[]("href")&.gsub("mailto:", "")
      website      = company_node.at_css("a[href^='http']")&.[]("href") || "https://chilepymes.com"

      # Saltar si no hay email
      next if email.blank?

      PublicEmailRecord.find_or_create_by(email: email) do |record|
        record.company_name = company_name
        record.website      = website
        record.address      = address
        record.city         = region
        record.municipality = nil
        record.country      = "Chile"
        record.description  = description
        record.industry     = nil # Por ahora
      end

      puts "✅ Guardado: #{email} | #{company_name}"
    end
  end
end
