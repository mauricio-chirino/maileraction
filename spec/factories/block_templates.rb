FactoryBot.define do
  factory :block_template do
    name { "MyString" }
    description { "MyText" }
    html_content { "MyText" }
    category { "MyString" }
    settings { "" }
    public { false }
    user { nil }
  end
end
