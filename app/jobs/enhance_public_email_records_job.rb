class EnhancePublicEmailRecordsJob < ApplicationJob
  queue_as :default

  def perform
    PublicEmailRecord.where(
      address: nil
    ).or(
      PublicEmailRecord.where(city: nil)
    ).or(
      PublicEmailRecord.where(municipality: nil)
    ).find_each do |record|
      PublicEmailRecordEnhancerService.new(record).enhance
    end
  end
end
