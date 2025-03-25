FactoryBot.define do
  factory :support_request do
    user { nil }
    message { "MyText" }
    category { "MyString" }
    status { "MyString" }
  end
end
