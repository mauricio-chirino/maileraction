FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.email }
    password { "password123" }
    role { "admin" } # o "user", según necesites
  end
end
