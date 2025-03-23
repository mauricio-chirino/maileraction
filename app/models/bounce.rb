class Bounce < ApplicationRecord
  belongs_to :email_record
  belongs_to :campaign, optional: true # opcional por los registros antiguos
end
