require "httparty"
require "nokogiri"
require "uri"

class PublicEmailScraperService
  def initialize(url)
    @url = url
  end

  def scrape_and_save
    response = HTTParty.get(@url)
    return unless response.success?

    doc = Nokogiri::HTML(response.body)

    emails = extract_emails(doc)
    return if emails.empty?

    company_name = doc.at_css('meta[property="og:site_name"]')&.[]("content") || URI.parse(@url).host
    description   = doc.at_css('meta[name="description"]')&.[]("content")
    industry      = detect_industry(company_name, description)

    industry_record = Industry.find_or_create_by(name: industry)

    emails.each do |email|
      next if personal_email?(email)

      PublicEmailRecord.find_or_create_by(email: email) do |record|
        record.website       = @url
        record.company_name  = company_name
        record.description   = description
        record.country       = "Chile"
        record.address       = nil
        record.municipality  = nil
        record.city          = nil
        record.industry      = industry_record
      end
    end
  rescue => e
    Rails.logger.error("❌ Error scraping #{@url}: #{e.message}")
  end

  private

  def extract_emails(doc)
    doc.xpath('//a[contains(@href, "mailto:")]')
       .map { |a| a["href"].gsub("mailto:", "") }
       .uniq
       .reject(&:blank?)
  end

  def personal_email?(email)
    email.match?(/@(gmail|yahoo|hotmail|outlook)\.com$/i)
  end

  def detect_industry(company_name, description)
    text = "#{company_name} #{description}".downcase

    return "logística"     if text.include?("logística")
    return "construcción"  if text.include?("construcción") || text.include?("constructora")
    return "retail"        if text.include?("retail") || text.include?("tienda")
    return "salud"         if text.include?("salud") || text.include?("clínica") || text.include?("hospital")
    return "tecnología"    if text.include?("tecnología") || text.include?("software") || text.include?("it")
    "otros"
  end
end
