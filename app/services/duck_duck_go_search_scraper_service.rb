require "httparty"
require "nokogiri"
require "addressable/uri"
require "i18n"

class DuckDuckGoSearchScraperService
  BASE_URL = "https://html.duckduckgo.com/html/".freeze
  USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122 Safari/537.36"

  def initialize(query, pages = 1)
    @query = query
    @pages = pages
  end

  def scrape
    @pages.times do |i|
      offset = i * 30
      response = HTTParty.post(
        BASE_URL,
        headers: { "User-Agent" => USER_AGENT },
        body: { q: @query, s: offset }
      )

      unless response.success?
        puts "❌ Error al buscar: #{response.code}"
        next
      end

      doc = Nokogiri::HTML(response.body)
      links = doc.css(".result__url").map { |a| "https://#{a.text.strip}" }.uniq
      puts "🔗 Resultados encontrados: #{links.count}"

      links.each { |url| scrape_site(url) }
    end
  end

  private

  def scrape_site(url)
    puts "🌐 Visitando: #{url}"
    response = HTTParty.get(url, headers: { "User-Agent" => USER_AGENT }, timeout: 10)
    return unless response.success?

    doc = Nokogiri::HTML(response.body)
    mailto = doc.at_xpath('//a[starts-with(@href, "mailto:")]')&.[]("href")
    email = mailto&.gsub("mailto:", "")
    puts "📧 Raw mailto: #{mailto}"
    puts "📬 Email extraído: #{email}"

    return unless email&.match?(URI::MailTo::EMAIL_REGEXP)

    record = PublicEmailRecord.find_or_initialize_by(email: email)

    industry_keyword = extract_industry_from_query(@query)
    industry = find_or_create_industry(industry_keyword)

    record.assign_attributes(
      website: url,
      company_name: extract_company_name(doc),
      address: extract_address(doc),
      municipality: extract_municipality(doc),
      city: extract_city(doc),
      country: "Chile",
      description: extract_description(doc),
      industry: industry,
      status: "pending",
      source_keyword: industry_keyword
    )

    if record.save
      puts "✅ Guardado: #{email} en #{url}"
    else
      puts "❌ No se guardó: #{email} en #{url}"
      puts "   Errores: #{record.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "❌ Error en #{url}: #{e.message}"
  end


  def extract_company_name(doc)
    doc.at_css("title")&.text&.strip&.truncate(100)
  end

  def extract_industry_from_query(query)
    query.downcase.split.find do |word|
      %w[
        logistica salud construccion retail tecnologia marketing contabilidad turismo
        veterinarias arquitectura consultorías seguridad educación odontología
        ingeniería software publicidad psicología
      ].include?(I18n.transliterate(word))
    end
  end

  def find_or_create_industry(keyword)
    return nil unless keyword

    match = Industry.all.find do |industry|
      I18n.transliterate(industry.name.to_s.downcase).include?(I18n.transliterate(keyword.downcase))
    end

    match || Industry.create!(name: keyword.capitalize)
  end

  def extract_company_name(doc)
    doc.at_css("meta[property='og:site_name']")&.[]("content") ||
    doc.at_css("title")&.text&.strip
  end

  def extract_description(doc)
    doc.at_css("meta[name='description']")&.[]("content")
  end

  def extract_address(doc)
    text = doc.text
    address_match = text.match(/(Av\.|Calle|Pasaje|Camino|Ruta)\s+[^\n]{5,100}/i)
    address_match&.to_s
  end

  def extract_municipality(doc)
    text = doc.text
    comuna_match = text.match(/comuna\s+de\s+([a-záéíóúñ\s]+)/i)
    comuna_match[1]&.strip if comuna_match
  end

  def extract_city(doc)
    text = doc.text
    ciudad_match = text.match(/ciudad\s+de\s+([a-záéíóúñ\s]+)/i)
    ciudad_match[1]&.strip if ciudad_match
  end
end
