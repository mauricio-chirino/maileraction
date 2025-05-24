FactoryBot.define do
  factory :email_block do
    campaign { nil }
    user { nil }
    block_template { nil }
    name { "MyString" }
    block_type { "MyString" }
    html_content { "MyText" }
    settings { "" }
    position { 1 }
  end
end
