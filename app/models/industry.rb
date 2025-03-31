class Industry < ApplicationRecord
  has_many :email_records
  has_many :campaigns
  has_many :public_email_records, dependent: :nullify



  validates :name, :name_en, presence: true
  validates :name, uniqueness: true
  validates :name_en, uniqueness: true

  scope :by_name, ->(name) { where(name: name) }

  def display(locale = :es)
    locale.to_s == "en" ? name_en : name
  end
end
