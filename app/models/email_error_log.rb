# app/models/email_error_log.rb
class EmailErrorLog < ApplicationRecord
  self.primary_key = "uuid"

  # Asociaciones, si las tienes
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  # belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true # Solo si la agregas en migración

  # Validaciones (ajusta según tus necesidades)
  # validates :error, presence: true
end
