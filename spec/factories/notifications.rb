FactoryBot.define do
  factory :notification do
    user { nil }
    title { "MyString" }
    body { "MyText" }
    read_at { "2025-03-25 04:37:58" }
    email_sent_at { "2025-03-25 04:37:58" }
  end
end
