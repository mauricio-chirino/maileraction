FactoryBot.define do
  factory :campaign do
    user
    industry
    email_limit { 5 }
    subject { "Campaña de prueba" }
    body { "<p>Contenido de prueba</p>" }
    status { "pending" }
  end
end
