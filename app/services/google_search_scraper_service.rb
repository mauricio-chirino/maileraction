require "httparty"
require "nokogiri"
require "addressable/uri"

class GoogleSearchScraperService
  GOOGLE_URL = "https://www.google.com/search".freeze
  USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "\
               "(KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"

  def initialize(query, pages = 1)
    @query = query
    @pages = pages
  end

  def scrape
    @pages.times do |i|
      start = i * 10
      url = "#{GOOGLE_URL}?q=#{URI.encode_www_form_component(@query)}&start=#{start}&hl=es"
      puts "🔎 Buscando: #{url}"

      response = HTTParty.get(url, headers: { "User-Agent" => USER_AGENT })
      next unless response.success?

      doc = Nokogiri::HTML(response.body)

      links = doc.css("a").map { |a| extract_url(a["href"]) }.compact.uniq
      puts "🔗 Enlaces encontrados: #{links.size}"

      links.each do |site_url|
        scrape_site(site_url)
      end
    end
  end

  private

  def extract_url(href)
    return unless href&.start_with?("/url?q=")
    uri = Addressable::URI.parse(href.split("/url?q=").last.split("&").first)
    uri.normalized.to_s
  rescue
    nil
  end

  def scrape_site(url)
    puts "🌐 Visitando #{url}"
    response = HTTParty.get(url, headers: { "User-Agent" => USER_AGENT }, timeout: 10)
    return unless response.success?

    doc = Nokogiri::HTML(response.body)
    email = doc.at_xpath('//a[starts-with(@href, "mailto:")]')&.[]("href")&.gsub("mailto:", "")

    return unless email

    PublicEmailRecord.find_or_create_by(email: email) do |record|
      record.website = url
      record.company_name = extract_company_name(doc)
      record.country = "Chile"
      record.address = nil
      record.city = nil
      record.municipality = nil
      record.description = nil
      record.industry = nil
    end

    puts "✅ Correo encontrado: #{email} en #{url}"
  rescue => e
    puts "❌ Error al visitar #{url}: #{e.message}"
  end

  def extract_company_name(doc)
    doc.at_css("title")&.text&.strip&.truncate(100)
  end
end
