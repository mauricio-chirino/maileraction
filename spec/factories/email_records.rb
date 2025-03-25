FactoryBot.define do
  factory :email_record do
    email { Faker::Internet.email }
    industry
  end
end
