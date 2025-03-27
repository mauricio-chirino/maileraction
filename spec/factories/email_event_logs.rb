FactoryBot.define do
  factory :email_event_log do
    email { "MyString" }
    event_type { "MyString" }
    metadata { "" }
    campaign { nil }
  end
end
