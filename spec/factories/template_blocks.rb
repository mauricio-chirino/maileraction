FactoryBot.define do
  factory :template_block do
    template { nil }
    block_type { "MyString" }
    html_content { "MyText" }
    settings { "" }
    position { 1 }
  end
end
