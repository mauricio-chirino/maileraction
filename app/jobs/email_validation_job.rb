# app/jobs/email_validation_job.rb
class EmailValidationJob < ApplicationJob
  queue_as :default

  def perform(limit = 1000)
    PublicEmailRecord.where(status: :unverified).limit(limit).find_each do |record|
      EmailValidatorService.new(record).validate
      puts "📧 Validado: #{record.email} → Estado: #{record.status}"
    end
  end
end
