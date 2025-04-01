require "nokogiri"
require "httparty"

class PublicEmailRecordEnhancerService
  def initialize(record)
    @record = record
  end

  def enhance
    return unless @record.website.present?

    response = HTTParty.get(@record.website, headers: { "User-Agent" => "Mozilla/5.0" })
    return unless response.success?

    doc = Nokogiri::HTML(response.body)

    address      = find_address(doc)
    municipality = find_municipality(doc)
    city         = find_city(doc)
    description  = doc.at('meta[name="description"]')&.[]("content") || doc.title

    @record.update(
      address: address.presence || @record.address,
      municipality: municipality.presence || @record.municipality,
      city: city.presence || @record.city,
      description: description.presence || @record.description
    )

    puts "✅ Datos mejorados para: #{@record.email}"
  rescue => e
    Rails.logger.error("❌ Error mejorando #{@record.website}: #{e.message}")
  end

  private

  def find_address(doc)
    doc.text[/((Av\.|Calle|Pasaje|Camino)\s+[^\n,]{5,50})/, 1]
  end

  def find_municipality(doc)
    doc.text[/comuna\s+de\s+([A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)/i, 1]
  end

  def find_city(doc)
    doc.text[/([A-ZÁÉÍÓÚÑ][a-záéíóúñ]+)\s+(Región|Chile)/, 1]
  end
end
