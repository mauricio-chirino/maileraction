# spec/factories/public_email_records.rb
FactoryBot.define do
  factory :public_email_record do
    email         { Faker::Internet.email }
    website       { Faker::Internet.url }
    address       { Faker::Address.street_address }
    municipality  { Faker::Address.community }
    city          { Faker::Address.city }
    country       { "Chile" }
    company_name  { Faker::Company.name }
    description   { Faker::Company.catch_phrase }
    source_keyword { "veterinaria" }
    status        { :verified }  # Usa el enum que tengas: :verified, :unverified, :rejected

    association :industry
  end
end
