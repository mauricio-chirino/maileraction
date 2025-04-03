FactoryBot.define do
  factory :template do
    name { "MyString" }
    subject { "MyString" }
    content_html { "MyText" }
    shared { false }
    user { nil }
  end
end
