# app/services/email_validator_service.rb
require "resolv"
require "uri"

class EmailValidatorService
  def initialize(email_record)
    @record = email_record
  end

  def validate
    email = @record.email

    if email.blank? || !valid_email_format?(email)
      update_status(:rejected)
      return
    end

    domain = email.split("@").last
    if domain_has_mx_records?(domain)
      update_status(:verified)
    else
      update_status(:rejected)
    end
  end

  private

  def update_status(new_status)
    if PublicEmailRecord.statuses.key?(new_status.to_s)
      @record.update(status: new_status)
    else
      Rails.logger.warn("⚠️ Estado no válido: #{new_status}")
    end
  end







  def valid_email_format?(email)
    URI::MailTo::EMAIL_REGEXP.match?(email)
  end

  def domain_has_mx_records?(domain)
    Resolv::DNS.open do |dns|
      mx_records = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      mx_records.any?
    end
  rescue Resolv::ResolvError
    false
  end
end
