class ResetIndustryEmailCountsJob < ApplicationJob
  queue_as :default

  def perform
    Industry.find_each do |industry|
      Industry.reset_counters(industry.id, :public_email_records)
    end
  end
end


# se ejecuta con
# desde la consola de rail
# rails c
# ResetIndustryEmailCountsJob.perform_later
