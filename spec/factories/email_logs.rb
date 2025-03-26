FactoryBot.define do
  factory :email_log do
    status { "error" }
    association :campaign
    association :email_record
  end
end
